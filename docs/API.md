# API Documentation

Complete API reference for all public packages in Airborne Submarine Squadron.

## Package: Game

**File**: `src/game.ads`, `src/game.adb`

**Purpose**: Core game engine and main game loop

### Types

#### Game_State

```ada
type Game_State is (Menu, Playing, Paused, Game_Over);
```

**Description**: Enumeration of possible game states

**Values**:
- `Menu`: Initial menu screen
- `Playing`: Active gameplay
- `Paused`: Game paused (future implementation)
- `Game_Over`: Game has ended

#### Delta_Time_Ms

```ada
subtype Delta_Time_Ms is Natural range 0 .. 1000;
```

**Description**: Frame delta time in milliseconds

**Range**: 0 to 1000 ms

**Typical Value**: 16 ms (60 FPS)

### Constants

```ada
Screen_Width  : constant := 800;
Screen_Height : constant := 600;
Target_FPS    : constant := 60;
```

### Procedures

#### Run

```ada
procedure Run with
   Global => null,
   Depends => (null => null);
```

**Description**: Initialize and run the game

**Parameters**: None

**Preconditions**: None

**Postconditions**: Game completes execution

**Side Effects**:
- Writes to terminal (stdout)
- Blocks until game ends

**Example**:
```ada
with Game;

procedure Main is
begin
   Game.Run;  --  Start the game
end Main;
```

---

## Package: Submarine

**File**: `src/submarine.ads`, `src/submarine.adb`

**Purpose**: Submarine entity management

### Types

#### Coordinate

```ada
subtype Coordinate is Integer range 0 .. 10_000;
```

**Description**: Screen coordinates (X or Y)

**Range**: 0 to 10,000 pixels

#### Velocity

```ada
subtype Velocity is Integer range -100 .. 100;
```

**Description**: Velocity in pixels per frame

**Range**: -100 (fast left/up) to +100 (fast right/down)

#### Health_Points

```ada
subtype Health_Points is Natural range 0 .. 100;
```

**Description**: Submarine health

**Range**: 0 (destroyed) to 100 (full health)

#### Submarine_Type

```ada
type Submarine_Type is private;
```

**Description**: Opaque submarine entity

**Invariants**:
- Health ∈ [0, 100]
- Name length ≤ 64 characters

### Functions

#### Create

```ada
function Create
   (X    : Coordinate;
    Y    : Coordinate;
    Name : String)
   return Submarine_Type
with
   Pre => Name'Length > 0 and Name'Length <= 64;
```

**Description**: Create a new submarine

**Parameters**:
- `X`: Initial X coordinate
- `Y`: Initial Y coordinate
- `Name`: Submarine name (1-64 characters)

**Preconditions**:
- Name length ∈ [1, 64]

**Returns**: New submarine entity

**Example**:
```ada
Sub : Submarine_Type := Create (
   X    => 400,
   Y    => 300,
   Name => "USS Freedom"
);
```

#### Get_X

```ada
function Get_X (Sub : Submarine_Type) return Coordinate;
```

**Description**: Get submarine X position

**Parameters**:
- `Sub`: Submarine to query

**Returns**: X coordinate (0-10,000)

**Example**:
```ada
X : Coordinate := Get_X (Sub);
```

#### Get_Y

```ada
function Get_Y (Sub : Submarine_Type) return Coordinate;
```

**Description**: Get submarine Y position

**Parameters**:
- `Sub`: Submarine to query

**Returns**: Y coordinate (0-10,000)

#### Get_VX

```ada
function Get_VX (Sub : Submarine_Type) return Velocity;
```

**Description**: Get submarine X velocity

**Parameters**:
- `Sub`: Submarine to query

**Returns**: X velocity (-100 to +100)

#### Get_VY

```ada
function Get_VY (Sub : Submarine_Type) return Velocity;
```

**Description**: Get submarine Y velocity

**Parameters**:
- `Sub`: Submarine to query

**Returns**: Y velocity (-100 to +100)

#### Get_Health

```ada
function Get_Health (Sub : Submarine_Type) return Health_Points;
```

**Description**: Get submarine health

**Parameters**:
- `Sub`: Submarine to query

**Returns**: Health (0-100)

#### Get_Name

```ada
function Get_Name (Sub : Submarine_Type) return String;
```

**Description**: Get submarine name

**Parameters**:
- `Sub`: Submarine to query

**Returns**: Submarine name string

### Procedures

#### Update

```ada
procedure Update
   (Sub     : in out Submarine_Type;
    Delta_T : Natural)
with
   Pre => Delta_T > 0 and Delta_T <= 1000;
```

**Description**: Update submarine physics for one frame

**Parameters**:
- `Sub`: Submarine to update (modified)
- `Delta_T`: Frame time in milliseconds (1-1000)

**Preconditions**:
- Delta_T ∈ [1, 1000] ms

**Side Effects**:
- Updates submarine position based on velocity
- Applies gravity to vertical velocity

**Example**:
```ada
Update (Sub, Delta_T => 16);  --  60 FPS frame
```

#### Take_Damage

```ada
procedure Take_Damage
   (Sub    : in out Submarine_Type;
    Amount : Health_Points);
```

**Description**: Apply damage to submarine

**Parameters**:
- `Sub`: Submarine to damage (modified)
- `Amount`: Damage amount (0-100)

**Side Effects**:
- Reduces health by `Amount`
- Clamps health to 0 (doesn't go negative)

**Example**:
```ada
Take_Damage (Sub, Amount => 25);  --  Submarine takes 25 damage
```

#### Apply_Buoyancy

```ada
procedure Apply_Buoyancy (Sub : in out Submarine_Type);
```

**Description**: Apply buoyancy effect (water environment)

**Parameters**:
- `Sub`: Submarine to modify

**Side Effects**:
- Reduces vertical velocity (simulates buoyancy)

**When to Call**: After submarine enters water

**Example**:
```ada
if Environment = Water then
   Apply_Buoyancy (Sub);
end if;
```

#### Apply_Aerodynamics

```ada
procedure Apply_Aerodynamics (Sub : in out Submarine_Type);
```

**Description**: Apply aerodynamic effects (air environment)

**Parameters**:
- `Sub`: Submarine to modify

**Side Effects**:
- Currently: None (gravity already applied in Update)

**When to Call**: After submarine enters air

**Example**:
```ada
if Environment = Air then
   Apply_Aerodynamics (Sub);
end if;
```

---

## Package: Environment

**File**: `src/environment.ads`, `src/environment.adb`

**Purpose**: Manage game environment (air/water)

### Types

#### Environment_Type

```ada
type Environment_Type is (Air, Water, Transition);
```

**Description**: Type of environment

**Values**:
- `Air`: Above water (full gravity, low drag)
- `Water`: Underwater (reduced gravity, high drag)
- `Transition`: Between air and water (average physics)

### Functions

#### To_String

```ada
function To_String (Env : Environment_Type) return String;
```

**Description**: Convert environment to string

**Parameters**:
- `Env`: Environment to convert

**Returns**: "AIR", "WATER", or "TRANSITION"

**Example**:
```ada
Put_Line ("Environment: " & To_String (Current_Env));
```

#### Gravity_Multiplier

```ada
function Gravity_Multiplier (Env : Environment_Type) return Float;
```

**Description**: Get gravity multiplier for environment

**Parameters**:
- `Env`: Environment to query

**Returns**:
- Air: 1.0 (full gravity)
- Water: 0.3 (buoyancy reduces gravity)
- Transition: 0.65 (average)

**Example**:
```ada
Gravity : Float := 9.8 * Gravity_Multiplier (Current_Env);
```

#### Drag_Multiplier

```ada
function Drag_Multiplier (Env : Environment_Type) return Float;
```

**Description**: Get drag coefficient for environment

**Parameters**:
- `Env`: Environment to query

**Returns**:
- Air: 0.98 (low drag)
- Water: 0.85 (high drag)
- Transition: 0.91 (average)

**Example**:
```ada
New_Velocity := Old_Velocity * Drag_Multiplier (Current_Env);
```

---

## Package: Physics

**File**: `src/physics.ads`, `src/physics.adb`

**Purpose**: Physics calculations and constants

### Constants

```ada
Gravity_Constant : constant := 9.8;  --  m/s^2 (scaled)
```

**Description**: Standard gravity constant

### Functions

#### Distance_Fallen

```ada
function Distance_Fallen
   (Initial_Velocity : Float;
    Time            : Float;
    Gravity         : Float := Gravity_Constant)
   return Float
with
   Pre => Time >= 0.0 and Gravity >= 0.0;
```

**Description**: Calculate distance fallen under gravity

**Formula**: `d = v₀ * t + ½ * g * t²`

**Parameters**:
- `Initial_Velocity`: Starting velocity (m/s)
- `Time`: Time elapsed (seconds)
- `Gravity`: Gravitational acceleration (m/s², default 9.8)

**Preconditions**:
- Time ≥ 0
- Gravity ≥ 0

**Returns**: Distance fallen (meters)

**Example**:
```ada
D : Float := Distance_Fallen (
   Initial_Velocity => 0.0,
   Time            => 2.0,
   Gravity         => 9.8
);
--  D = 0 + 0.5 * 9.8 * 4 = 19.6 meters
```

#### Apply_Drag

```ada
function Apply_Drag
   (Velocity        : Float;
    Drag_Coefficient : Float)
   return Float
with
   Pre => Drag_Coefficient >= 0.0 and Drag_Coefficient <= 1.0;
```

**Description**: Apply drag to velocity

**Formula**: `v_new = v_old * drag_coefficient`

**Parameters**:
- `Velocity`: Current velocity
- `Drag_Coefficient`: Drag coefficient (0.0-1.0)

**Preconditions**:
- Drag coefficient ∈ [0.0, 1.0]

**Returns**: New velocity after drag

**Example**:
```ada
New_V : Float := Apply_Drag (
   Velocity        => 100.0,
   Drag_Coefficient => 0.98
);
--  New_V = 98.0
```

---

## Package: Renderer

**File**: `src/renderer.ads`, `src/renderer.adb`

**Purpose**: Text-based rendering (terminal output)

### Procedures

#### Render_Status

```ada
procedure Render_Status
   (Sub     : Submarine.Submarine_Type;
    Env     : Environment.Environment_Type;
    Seconds : Natural);
```

**Description**: Render submarine status to terminal

**Parameters**:
- `Sub`: Submarine to render
- `Env`: Current environment
- `Seconds`: Game time in seconds

**Side Effects**:
- Writes formatted output to stdout

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

**Example**:
```ada
Render_Status (Player_Sub, Current_Env, Elapsed_Seconds);
```

---

## Error Handling

### Exception Types

All packages use standard Ada exceptions:

- **`Constraint_Error`**: Raised when preconditions violated (e.g., invalid range)
- **`Program_Error`**: Raised for logic errors (shouldn't occur in correct code)
- **`Storage_Error`**: Raised if stack overflow (very unlikely)

### Precondition Failures

Example:
```ada
Sub : Submarine_Type := Create (
   X    => 100,
   Y    => 100,
   Name => ""  --  ❌ Empty name
);
--  Raises: Constraint_Error (Name'Length = 0 violates precondition)
```

### Type Safety

Example:
```ada
X : Coordinate := -100;  --  ❌ Out of range
--  Compile error: value -100 not in range 0 .. 10000
```

---

## Usage Examples

### Complete Game Loop

```ada
with Game;
with Submarine;
with Environment;
with Renderer;

procedure Example is
   Sub : Submarine.Submarine_Type;
   Env : Environment.Environment_Type := Environment.Air;
begin
   --  Create submarine
   Sub := Submarine.Create (X => 400, Y => 100, Name => "Test");

   --  Simulate a few frames
   for Frame in 1 .. 120 loop  --  2 seconds at 60 FPS
      --  Update physics
      Submarine.Update (Sub, Delta_T => 16);

      --  Check environment
      if Submarine.Get_Y (Sub) > 300 then
         Env := Environment.Water;
         Submarine.Apply_Buoyancy (Sub);
      else
         Env := Environment.Air;
      end if;

      --  Render every 60 frames (1 second)
      if Frame mod 60 = 0 then
         Renderer.Render_Status (Sub, Env, Frame / 60);
      end if;
   end loop;
end Example;
```

---

## Thread Safety

**Current**: Not thread-safe (single-threaded design)

**Future**: Protected types for concurrent access

Example (future):
```ada
protected Submarine_State is
   procedure Update (Delta_T : Natural);
   function Get_Position return Position_Type;
private
   Sub : Submarine_Type;
end Submarine_State;
```

---

## SPARK Contracts

All packages support SPARK verification:

```ada
--  Packages with SPARK_Mode => On
--  Functions with preconditions (Pre aspect)
--  Procedures with dependencies (Depends aspect)
```

Verify with:
```bash
gnatprove -P submarine_squadron.gpr --level=2 --mode=flow
```

---

**Document Version**: 1.0
**Last Updated**: 2025-01-22
**Maintainer**: API Documentation Team

