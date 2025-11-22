# Contributing to Airborne Submarine Squadron

Thank you for your interest in contributing! This document provides guidelines for contributing to the project.

## 🌟 Quick Start

1. **Read the Code of Conduct**: [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)
2. **Check existing issues**: [GitHub Issues](https://github.com/Hyperpolymath/airborne-submarine-squadron/issues)
3. **Fork the repository**
4. **Create a feature branch**: `git checkout -b feature/your-feature`
5. **Make your changes**
6. **Run tests**: `just test`
7. **Submit a pull request**

## 🔐 TPCF: Tri-Perimeter Contribution Framework

This project uses **TPCF Perimeter 3 (Community Sandbox)**, which means:

### Perimeter 3: Community Sandbox

✅ **Public Contributions Welcome**
- Anyone can submit issues
- Anyone can submit pull requests
- Public discussions encouraged

⚠️ **Review Required**
- All PRs reviewed by maintainers
- Breaking changes require RFC (Request for Comments)
- Security-sensitive changes require 2+ approvals

📋 **Governance**
- Decisions made through consensus
- Maintainers have final say on disputes
- See [MAINTAINERS.md](MAINTAINERS.md) for governance structure

### TPCF Perimeters Explained

- **Perimeter 1 (Trusted Core)**: Maintainers only, high-trust, direct commit access
- **Perimeter 2 (Contributor Circle)**: Vetted contributors, streamlined review
- **Perimeter 3 (Community Sandbox)**: ← **We are here** ← Public contributions
- **Perimeter 4 (View-Only)**: Read access only, no contributions

## 📝 Contribution Types

### Bug Reports

**Before submitting**:
- Search existing issues to avoid duplicates
- Verify the bug in the latest version
- Collect reproduction steps

**Good bug report includes**:
- **Description**: What went wrong?
- **Expected Behavior**: What should have happened?
- **Actual Behavior**: What actually happened?
- **Steps to Reproduce**: How can we reproduce it?
- **Environment**: OS, GNAT version, etc.
- **Logs**: Relevant error messages or logs

**Template**:
```markdown
### Description
[Clear description of the bug]

### Expected Behavior
[What should happen]

### Actual Behavior
[What actually happens]

### Steps to Reproduce
1. Step one
2. Step two
3. Step three

### Environment
- OS: [e.g., Ubuntu 24.04]
- GNAT Version: [e.g., FSF 13.2]
- Game Version: [e.g., 0.3.0]

### Logs
```
[Paste relevant logs here]
```
```

### Feature Requests

**Before requesting**:
- Check if feature already requested
- Consider if it fits project scope
- Think about implementation approach

**Good feature request includes**:
- **Problem**: What problem does this solve?
- **Proposed Solution**: How would you solve it?
- **Alternatives**: Other approaches considered
- **Impact**: Who benefits from this?

**Template**:
```markdown
### Problem
[Describe the problem this feature would solve]

### Proposed Solution
[Your proposed approach]

### Alternatives Considered
[Other ways to solve this]

### Additional Context
[Any other relevant information]
```

### Code Contributions

**Contribution Workflow**:

1. **Fork & Clone**
   ```bash
   git clone https://github.com/YOUR_USERNAME/airborne-submarine-squadron.git
   cd airborne-submarine-squadron
   ```

2. **Create Branch**
   ```bash
   git checkout -b feature/my-feature
   # OR
   git checkout -b bugfix/fix-issue-123
   ```

3. **Make Changes**
   - Write clean, idiomatic Ada 2022 code
   - Follow coding standards (see below)
   - Add tests for new functionality
   - Update documentation

4. **Test Locally**
   ```bash
   just build        # Compile
   just test         # Run tests
   just verify       # SPARK verification
   just lint         # Static analysis
   ```

5. **Commit**
   ```bash
   git add .
   git commit -m "feat: add submarine speed boost"
   ```

6. **Push**
   ```bash
   git push origin feature/my-feature
   ```

7. **Create Pull Request**
   - Use PR template
   - Reference related issues
   - Describe changes clearly

## 💻 Coding Standards

### Ada Style Guide

**General Principles**:
- **Clarity over cleverness**: Code should be obvious
- **Type safety first**: Use Ada's strong typing
- **No unsafe code**: Zero `Unchecked_*` operations
- **SPARK-compatible**: All code should verify with SPARK

**Naming Conventions**:
```ada
-- Packages: Title_Case
package Game.Submarine is

-- Types: Title_Case with _Type suffix
type Submarine_Type is private;
type Velocity_Type is range -100 .. 100;

-- Constants: Title_Case with _Constant suffix (if not obvious)
Max_Speed_Constant : constant := 100;
Default_Depth : constant := 50;

-- Variables: Snake_Case
submarine_position : Position_Type;
current_velocity : Velocity_Type;

-- Functions: Title_Case (noun or adjective)
function Is_Submerged (Sub : Submarine_Type) return Boolean;
function Current_Speed (Sub : Submarine_Type) return Natural;

-- Procedures: Title_Case (verb)
procedure Submerge (Sub : in out Submarine_Type);
procedure Fire_Torpedo (Sub : in Submarine_Type; Target : Position_Type);
```

**Formatting**:
- **Indentation**: 3 spaces (Ada standard)
- **Line Length**: 80 characters max
- **Comments**: `--` for inline, full sentences
- **Spacing**: Space after `:=`, around operators

**Example**:
```ada
--  File: src/game/submarine.ads
--  Purpose: Submarine entity management

package Game.Submarine is

   --  Maximum submarine speed in pixels per frame
   Max_Speed : constant := 100;

   --  Submarine state type
   type Submarine_Type is private;

   --  Creates a new submarine at the given position
   function Create
      (Position : Position_Type;
       Name     : String)
      return Submarine_Type
   with
      Pre => Name'Length > 0 and Name'Length <= 64;

   --  Updates submarine physics for one frame
   procedure Update
      (Sub      : in out Submarine_Type;
       Delta_T  : Duration)
   with
      Pre => Delta_T > 0.0;

private

   type Submarine_Type is record
      Position : Position_Type;
      Velocity : Velocity_Type;
      Health   : Health_Type := 100;
   end record
   with
      Invariant => Health in 0 .. 100;

end Game.Submarine;
```

### SPARK Compliance

All code must be SPARK-compatible:

**Required**:
- ✅ No `Unchecked_*` operations
- ✅ No access types (pointers) unless absolutely necessary
- ✅ No recursion (or use `--# recursive` pragma)
- ✅ Preconditions and postconditions on public APIs
- ✅ Type invariants on private types

**Example**:
```ada
function Calculate_Speed
   (Distance : Natural;
    Time     : Positive)
   return Natural
with
   Pre  => Distance <= 10_000,  -- Prevent overflow
   Post => Calculate_Speed'Result <= Max_Speed;
```

### Documentation

**Inline Comments**:
```ada
--  Brief description of what this does
procedure Complex_Operation (X : Integer) is
   --  Local variable explanation if non-obvious
   Temp_Value : Natural;
begin
   --  Step-by-step explanation for complex logic
   Temp_Value := X * 2;

   --  Explain non-obvious decisions
   if Temp_Value > 100 then  --  Prevent overflow
      Temp_Value := 100;
   end if;
end Complex_Operation;
```

**Package Documentation**:
```ada
--  =================================================================
--  Game.Submarine - Submarine entity management
--  =================================================================
--
--  This package handles all submarine-related operations including
--  movement, collision detection, and weapon firing.
--
--  Key features:
--    * Physics simulation (air and water)
--    * Collision detection with terrain and entities
--    * Weapon systems (torpedoes, missiles)
--    * Health and damage management
--
--  Dependencies:
--    * Game.Physics - Physics calculations
--    * Game.Weapons - Weapon systems
--
--  Thread Safety: Not thread-safe (single-threaded game)
--  SPARK: Fully verified
--  =================================================================

package Game.Submarine is
   ...
end Game.Submarine;
```

## 🧪 Testing Requirements

### Test Coverage

**Required**:
- ✅ Unit tests for all public APIs
- ✅ Integration tests for subsystem interactions
- ✅ SPARK verification for all critical code
- ✅ No regression tests failing

**Running Tests**:
```bash
# All tests
just test

# Specific test suite
just test-unit
just test-integration
just test-spark

# With coverage
just coverage

# Specific test
just test-one submarine_movement
```

### Writing Tests

**Test Structure**:
```ada
--  File: tests/test_submarine.adb

with AUnit; use AUnit;
with AUnit.Test_Cases; use AUnit.Test_Cases;
with Game.Submarine; use Game.Submarine;

package body Test_Submarine is

   --  Test case: Submarine moves correctly
   procedure Test_Movement (T : in out Test_Case'Class) is
      Sub : Submarine_Type := Create ((X => 0, Y => 0), "TestSub");
   begin
      --  Arrange
      Set_Velocity (Sub, (X => 10, Y => 0));

      --  Act
      Update (Sub, Delta_T => 1.0);

      --  Assert
      Assert (Get_Position (Sub).X = 10, "Submarine should move right");
      Assert (Get_Position (Sub).Y = 0, "Submarine should not move vertically");
   end Test_Movement;

end Test_Submarine;
```

## 🔍 Code Review Process

### Reviewer Checklist

- [ ] Code follows Ada style guide
- [ ] SPARK verification passes
- [ ] Tests added for new functionality
- [ ] All tests pass
- [ ] Documentation updated
- [ ] No unsafe operations introduced
- [ ] No unnecessary dependencies added
- [ ] Performance acceptable
- [ ] Security implications considered

### PR Review Timeline

- **24 hours**: Initial triage
- **7 days**: Review and feedback
- **14 days**: Merge or request changes
- **30 days**: Stale (will be closed if no updates)

### Merge Criteria

**Required**:
- ✅ 1+ approvals from maintainers
- ✅ All CI checks pass
- ✅ No unresolved review comments
- ✅ Conflicts resolved
- ✅ Commit messages follow convention

**For Breaking Changes**:
- ✅ RFC approved
- ✅ 2+ maintainer approvals
- ✅ Migration guide provided
- ✅ Deprecation period observed (1 minor version)

## 📋 Commit Message Convention

We use **Conventional Commits**:

**Format**:
```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types**:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style (formatting, no logic change)
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `test`: Adding or updating tests
- `chore`: Build process, tooling, dependencies

**Examples**:
```
feat(submarine): add speed boost powerup

Adds a temporary speed boost powerup that doubles submarine speed
for 10 seconds.

Closes #123
```

```
fix(physics): correct water buoyancy calculation

Previous calculation used incorrect density constant, causing
submarines to sink too quickly.

Fixes #456
```

```
docs(contributing): clarify TPCF perimeter 3 guidelines

Breaking change: Rename perimeter levels for clarity

BREAKING CHANGE: Perimeter numbering changed from 4-1 to 1-4
```

## 🚀 Release Process

### Versioning

We follow **Semantic Versioning (SemVer)**:
- **Major** (x.0.0): Breaking changes
- **Minor** (0.x.0): New features (backward-compatible)
- **Patch** (0.0.x): Bug fixes (backward-compatible)

### Release Checklist

- [ ] All tests pass
- [ ] SPARK verification complete
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
- [ ] Version bumped in relevant files
- [ ] Git tag created and signed
- [ ] Release notes written
- [ ] Artifacts built and signed

## 🌍 Community

### Communication Channels

- **GitHub Issues**: Bug reports, feature requests
- **GitHub Discussions**: General discussion, Q&A
- **Matrix**: `#airborne-submarine:matrix.org`
- **IRC**: `#airborne-submarine` on Libera.Chat

### Getting Help

- **Documentation**: Start with [README.md](README.md)
- **Architecture**: See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)
- **API**: See [docs/API.md](docs/API.md)
- **Ask**: Create a GitHub Discussion

## 📜 Legal

### Licensing

- All contributions licensed under dual MIT + Palimpsest v0.8
- See [LICENSE.txt](LICENSE.txt) for details
- By contributing, you agree to license your contribution under these terms

### Contributor License Agreement (CLA)

**Not required** - By submitting a PR, you affirm:
- You have the right to contribute the code
- You license it under the project's dual license
- You understand the Palimpsest License's political autonomy provisions

### Attribution

- Contributors credited in [.well-known/humans.txt](.well-known/humans.txt)
- Significant contributions noted in CHANGELOG.md
- Maintainers listed in [MAINTAINERS.md](MAINTAINERS.md)

## ❤️ Recognition

We value all contributions:
- 🐛 **Bug Reports**: Help us improve stability
- 💡 **Feature Ideas**: Drive the project forward
- 📝 **Documentation**: Make the project accessible
- 💻 **Code**: Build new capabilities
- 🧪 **Testing**: Ensure quality
- 🎨 **Design**: Improve user experience
- 🌍 **Translation**: Reach more users

Thank you for contributing to Airborne Submarine Squadron!

---

**Questions?** Open a [GitHub Discussion](https://github.com/Hyperpolymath/airborne-submarine-squadron/discussions) or ask on Matrix.

