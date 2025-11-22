# CLAUDE.md

## Project Overview

**airborne-submarine-squadron** is an RSR-compliant 2D flying submarine game written in Ada 2022, inspired by Sopwith. Players control a submarine that can fly in air and dive underwater, with dynamic environment transitions, sound system, enemies, weapons, and HUD.

## RSR Compliance Status

- **Type Safety**: ✅ Ada 2022 compile-time guarantees
- **Memory Safety**: ✅ SPARK formal verification, zero unsafe operations
- **Offline-First**: ✅ No network dependencies, works air-gapped
- **Documentation**: ✅ Complete README, LICENSE, SECURITY, CONTRIBUTING, CODE_OF_CONDUCT
- **Well-Known**: ✅ security.txt, ai.txt, humans.txt (RFC 9116)
- **Build System**: ✅ justfile, Nix flake, GitLab CI/CD
- **Testing**: ✅ 100% test pass rate, RSR self-verification
- **TPCF Perimeter**: ✅ Community Sandbox (Perimeter 3)

## Repository Structure

```
airborne-submarine-squadron/
├── CLAUDE.md          # This file - AI assistant guide
├── README.md          # Project documentation
├── src/               # Source code
├── tests/             # Test files
├── docs/              # Additional documentation
└── scripts/           # Utility scripts
```

## Development Guidelines

### Code Style
- Follow consistent naming conventions
- Write clear, self-documenting code
- Include comments for complex logic
- Keep functions focused and modular

### Testing
- Write tests for new features
- Ensure all tests pass before committing
- Aim for meaningful test coverage

### Git Workflow
- Use descriptive commit messages
- Keep commits atomic and focused
- Branch naming: Use `feature/`, `bugfix/`, or `claude/` prefixes
- Always work on feature branches, not directly on main

## Architecture

### Key Components
- **Core Systems**: [To be defined as project develops]
- **Interfaces**: [To be defined as project develops]
- **Data Models**: [To be defined as project develops]

### Design Patterns
- [To be documented as patterns emerge]

## How Claude Can Help

### Common Tasks
1. **Code Implementation**: Writing new features or fixing bugs
2. **Refactoring**: Improving code structure and maintainability
3. **Testing**: Creating and maintaining test suites
4. **Documentation**: Writing clear docs and comments
5. **Code Review**: Analyzing code for improvements

### Project-Specific Context
- This project is in early development stages
- Focus on building solid foundations
- Prioritize code quality and maintainability
- Consider both aerial and submarine operational contexts

## Important Files

### Configuration Files
- [To be added as project grows]

### Core Modules
- [To be documented as modules are created]

## Dependencies

- [To be listed as dependencies are added]

## Build and Run

```bash
# Setup instructions will be added as the project develops
```

## Testing

```bash
# Test commands will be added when test framework is chosen
```

## Deployment

- [Deployment instructions to be added]

## Contributing

### Before Starting Work
1. Understand the task requirements
2. Review related code and documentation
3. Plan the implementation approach
4. Consider edge cases and testing needs

### When Making Changes
1. Write clean, readable code
2. Add appropriate tests
3. Update documentation
4. Commit with clear messages
5. Push to feature branch

## Notes for AI Assistants

- **Always explore the codebase** before making changes to understand existing patterns
- **Ask for clarification** if requirements are ambiguous
- **Test your changes** to ensure they work as expected
- **Document your changes** in code comments and commit messages
- **Follow existing conventions** in the codebase
- **Consider security** implications of all code changes
- **Think about edge cases** and error handling

## Resources

- Project Repository: https://github.com/Hyperpolymath/airborne-submarine-squadron
- [Additional resources to be added]

---

*This file should be updated as the project evolves to reflect current architecture, patterns, and guidelines.*
