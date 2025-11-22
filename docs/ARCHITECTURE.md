# Architecture Documentation

## Overview

Airborne Submarine Squadron is a 2D flying submarine game built with Ada 2022, emphasizing type safety, memory safety, and offline-first operation.

## Design Principles

### 1. Type Safety First

All operations use Ada's strong type system:
- **Range-constrained types**: `Coordinate`, `Velocity`, `Health_Points`
- **Enumeration types**: `Game_State`, `Environment_Type`
- **No implicit conversions**: Explicit type conversions required
- **Compile-time checks**: Invalid operations caught at compile time

### 2. Memory Safety

Memory safety ensured through:
- **SPARK verification**: Mathematical proofs of memory safety
- **No pointers**: Uses records and arrays (value types)
- **Bounded data structures**: Fixed-size buffers (e.g., `Name_Buffer`)
- **No `Unchecked_*` operations**: Zero unsafe code
- **Automatic memory management**: No manual allocation/deallocation

### 3. Offline-First

Complete air-gapped operation:
- **Zero network dependencies**: No sockets, HTTP, external APIs
- **No telemetry**: No usage tracking or analytics
- **Local assets only**: All resources embedded or local files
- **Reproducible builds**: Nix flake ensures determinism

### 4. Modularity

Clear separation of concerns:
- **Game**: Main game loop and state management
- **Submarine**: Entity management
- **Environment**: World state (air/water)
- **Physics**: Calculations and constants
- **Renderer**: Display abstraction

## System Architecture

```
┌─────────────────────────────────────────────────────────┐
│                     Main Entry Point                     │
│                      (main.adb)                          │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│                    Game Loop (game.adb)                  │
│  ┌──────────────────────────────────────────────────┐   │
│  │ State: Menu | Playing | Paused | Game_Over      │   │
│  └──────────────────────────────────────────────────┘   │
│                                                          │
│  Flow:                                                   │
│    1. Initialize submarine                               │
│    2. Main loop:                                         │
│       - Update physics (16ms delta)                      │
│       - Check environment transitions                    │
│       - Apply environment effects                        │
│       - Render status                                    │
│       - Check game over conditions                       │
│    3. Display final statistics                           │
└─────────┬───────────────┬──────────────┬────────────────┘
          │               │              │
          ▼               ▼              ▼
┌─────────────┐  ┌───────────────┐  ┌──────────┐
│  Submarine  │  │  Environment  │  │  Physics │
│   Package   │  │    Package    │  │  Package │
└─────────────┘  └───────────────┘  └──────────┘
          │               │              │
          └───────────────┴──────────────┘
                      │
                      ▼
              ┌──────────────┐
              │   Renderer   │
              │   Package    │
              └──────────────┘
```

## Package Descriptions

### Main (main.adb)

**Purpose**: Entry point for the application

**Responsibilities**:
- Initialize runtime
- Display splash screen
- Call `Game.Run`
- Handle top-level exceptions

**Dependencies**: `Ada.Text_IO`, `Game`

**SPARK Mode**: On

### Game Package (game.ads/adb)

**Purpose**: Core game engine and main game loop

**Key Types**:
- `Game_State`: Enumeration of game states
- `Delta_Time_Ms`: Frame time in milliseconds

**Public API**:
- `procedure Run`: Initialize and run the game

**Responsibilities**:
- Game state management
- Frame timing (60 FPS target)
- Environment transition detection
- Orchestrate all systems

**Dependencies**: `Submarine`, `Environment`, `Physics`, `Renderer`

**SPARK Mode**: On

### Submarine Package (submarine.ads/adb)

**Purpose**: Submarine entity management

**Key Types**:
- `Coordinate`: Range 0 .. 10_000
- `Velocity`: Range -100 .. 100
- `Health_Points`: Range 0 .. 100
- `Submarine_Type`: Private record

**Public API**:
```ada
function Create (X, Y : Coordinate; Name : String) return Submarine_Type;
procedure Update (Sub : in out Submarine_Type; Delta_T : Natural);
function Get_X (Sub : Submarine_Type) return Coordinate;
function Get_Y (Sub : Submarine_Type) return Coordinate;
function Get_VX (Sub : Submarine_Type) return Velocity;
function Get_VY (Sub : Submarine_Type) return Velocity;
function Get_Health (Sub : Submarine_Type) return Health_Points;
function Get_Name (Sub : Submarine_Type) return String;
procedure Take_Damage (Sub : in out Submarine_Type; Amount : Health_Points);
procedure Apply_Buoyancy (Sub : in out Submarine_Type);
procedure Apply_Aerodynamics (Sub : in out Submarine_Type);
```

**Invariants**:
- Health always in range 0 .. 100
- Name length ≤ 64 characters
- Position within valid coordinate range

**Dependencies**: None (leaf package)

**SPARK Mode**: On

### Environment Package (environment.ads/adb)

**Purpose**: Manage game environment (air/water)

**Key Types**:
- `Environment_Type`: Air | Water | Transition

**Public API**:
```ada
function To_String (Env : Environment_Type) return String;
function Gravity_Multiplier (Env : Environment_Type) return Float;
function Drag_Multiplier (Env : Environment_Type) return Float;
```

**Physics Parameters**:
- **Air**: Gravity 1.0x, Drag 0.98
- **Water**: Gravity 0.3x, Drag 0.85 (buoyancy effect)
- **Transition**: Midpoint values

**Dependencies**: None (leaf package)

**SPARK Mode**: On

### Physics Package (physics.ads/adb)

**Purpose**: Physics calculations and constants

**Constants**:
- `Gravity_Constant`: 9.8 m/s² (scaled)

**Public API**:
```ada
function Distance_Fallen (Initial_Velocity, Time, Gravity : Float) return Float;
function Apply_Drag (Velocity, Drag_Coefficient : Float) return Float;
```

**Preconditions**:
- Time ≥ 0.0
- Gravity ≥ 0.0
- Drag coefficient ∈ [0.0, 1.0]

**Dependencies**: None (leaf package)

**SPARK Mode**: On

### Renderer Package (renderer.ads/adb)

**Purpose**: Text-based rendering (terminal output)

**Public API**:
```ada
procedure Render_Status (Sub : Submarine_Type; Env : Environment_Type; Seconds : Natural);
```

**Output Format**:
```
╔═══════════════════════════════════════════════╗
║  Airborne Submarine Squadron - Status HUD    ║
╠═══════════════════════════════════════════════╣
║  Time: 5s
║  Submarine: USS Freedom
║  Position: (400, 350)
║  Velocity: (0, 15)
║  Health: 100/100
║  Environment: WATER
╚═══════════════════════════════════════════════╝
```

**Dependencies**: `Ada.Text_IO`, `Submarine`, `Environment`

**SPARK Mode**: On

## Data Flow

```
User Input (simulated)
    │
    ▼
Game Loop (16ms frames)
    │
    ├─→ Submarine.Update (apply physics)
    │       │
    │       └─→ Physics calculations
    │
    ├─→ Environment check (Y position)
    │       │
    │       └─→ Apply_Buoyancy or Apply_Aerodynamics
    │
    ├─→ Renderer.Render_Status (every 60 frames)
    │
    └─→ Check game over conditions
```

## State Transitions

```
┌──────┐  Enter Key   ┌─────────┐  Health = 0  ┌───────────┐
│ Menu ├─────────────→│ Playing ├─────────────→│ Game Over │
└──────┘              └────┬────┘              └───────────┘
                           │ ▲
                      Esc  │ │ Esc
                           ▼ │
                      ┌────────┐
                      │ Paused │
                      └────────┘
```

## Memory Model

All data is stack-allocated or static:

```ada
--  Game loop local variables
Current_State : Game_State;           -- 1 byte (enum)
Frame_Count   : Natural;              -- 4 bytes
Running       : Boolean;              -- 1 byte
Player_Sub    : Submarine_Type;       -- ~80 bytes (record)
Current_Env   : Environment_Type;     -- 1 byte (enum)
                                      ────────────
                                      ~87 bytes total
```

No heap allocation, no garbage collection.

## Concurrency Model

**Current**: Single-threaded

**Future**:
- Separate rendering task (protected objects)
- Input handling task
- Sound system task

All communication via protected objects (no shared mutable state).

## Error Handling

**Strategy**: Fail-fast with exceptions

**Exception Safety**:
- All operations either succeed or raise exception
- No partial state updates
- Resource cleanup via controlled types (future)

**Preconditions**:
- Checked at compile-time (SPARK) or runtime (assertions)
- Invalid inputs cause `Constraint_Error`

## Performance Characteristics

**Target**: 60 FPS (16ms per frame)

**Bottlenecks**:
- Currently: Terminal I/O (text rendering)
- Future: Graphics rendering, collision detection

**Optimizations**:
- Release build: `-O2`, inlining, loop unrolling
- SPARK verification: Proves absence of runtime errors

## Security Model

**Threat Model**: Offline single-player game

**Security Features**:
1. **No network attack surface**: Zero network code
2. **Memory safety**: SPARK verified, no buffer overflows
3. **Type safety**: No type confusion attacks
4. **No code injection**: No dynamic code loading
5. **Deterministic**: No randomness (yet), fully reproducible

**Out of Scope**:
- Multi-player security
- Server-side validation
- Network protocol security

## Scalability

**Current Scale**:
- Single submarine
- 300 frames (~5 seconds demo)
- Text rendering

**Future Scale**:
- Multiple enemies (10-20)
- Projectiles (50-100)
- Particle effects (1000+)
- Larger world (scrolling)

**Design for Scale**:
- Entity Component System (ECS) pattern
- Spatial hashing for collision detection
- Object pooling for projectiles

## Testing Strategy

**Unit Tests**:
- Each package tested independently
- Test: `tests/test_submarine.adb`
- Coverage: All public APIs

**Integration Tests**:
- Full game loop execution
- Environment transitions
- Game state changes

**SPARK Verification**:
- Proves: No runtime errors, no buffer overflows, type safety
- Level 2: Flow analysis
- Level 4: Full proof (future)

**Property-Based Tests** (Future):
- Invariants hold across all inputs
- No integer overflow
- Position always valid

## Build System

**Tools**:
- **GNAT**: Ada 2022 compiler
- **GPRbuild**: Project-aware build tool
- **Just**: Command runner (make replacement)
- **Nix**: Reproducible builds

**Build Modes**:
- **Debug**: `-O0 -g -gnata` (assertions, debug symbols)
- **Release**: `-O2 -gnatn` (optimized, inlined)
- **SPARK**: `-gnatd.F` (SPARK mode)

**Artifacts**:
- `bin/main`: Executable
- `obj/*.o`: Object files
- `obj/*.ali`: Ada Library Info

## Deployment

**Platforms**:
- Linux (primary)
- macOS (via Nix)
- Windows (native GNAT or WSL2)
- BSDs

**Distribution**:
- Source tarball (`.tar.gz`)
- Nix flake (reproducible)
- Binary releases (GitHub Releases)

**Installation**:
- System package managers (future: apt, dnf, brew)
- Nix: `nix profile install`
- Manual: `gprbuild && cp bin/main /usr/local/bin/`

## Future Enhancements

### Short Term
- [ ] Graphics rendering (SDL2 or similar)
- [ ] Keyboard input handling
- [ ] Scrolling world
- [ ] Multiple enemy types
- [ ] Collision detection

### Medium Term
- [ ] Sound system (music + SFX)
- [ ] Mission system
- [ ] Weapon variety
- [ ] Power-ups
- [ ] HUD improvements

### Long Term
- [ ] Save/load game state
- [ ] Level editor
- [ ] Modding support
- [ ] Multiplayer (local co-op)
- [ ] Mobile ports (iOS/Android via cross-compilation)

## Appendix: Design Decisions

### Why Ada 2022?

- **Type Safety**: Strongest type system of mainstream languages
- **Memory Safety**: No manual memory management
- **Proven**: Used in safety-critical systems (avionics, rail)
- **SPARK**: Formal verification without annotations
- **Readable**: Self-documenting code

### Why SPARK?

- **Provable Correctness**: Mathematical proof of properties
- **No Runtime Errors**: Proves absence of crashes
- **Security**: Eliminates entire vulnerability classes
- **Free**: Open-source tooling

### Why Offline-First?

- **Privacy**: No telemetry or tracking
- **Security**: No network attack surface
- **Reliability**: Works anywhere (air-gapped, remote)
- **Speed**: No network latency
- **Simplicity**: Fewer dependencies

### Why Text Rendering Initially?

- **Rapid Development**: Faster than graphics setup
- **Platform Independence**: Works on any terminal
- **Debugging**: Easy to inspect state
- **Accessibility**: Screen reader compatible
- **Future**: Graphics layer can replace renderer module

---

**Document Version**: 1.0
**Last Updated**: 2025-01-22
**Maintainer**: Architecture Team

