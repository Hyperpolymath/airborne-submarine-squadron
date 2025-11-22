# Installation Guide

This guide covers installation of the Airborne Submarine Squadron game on various platforms.

## Quick Start (Nix Users)

If you have Nix with flakes enabled:

```bash
# Clone the repository
git clone https://github.com/Hyperpolymath/airborne-submarine-squadron.git
cd airborne-submarine-squadron

# Build and run
nix run

# Or enter development environment
nix develop
just build
just run
```

## Requirements

### Minimum Requirements

- **OS**: Linux, macOS, BSDs, or Windows (WSL2/native)
- **Compiler**: GNAT Ada 2022 (FSF 13.0+ or AdaCore GNAT Community 2024)
- **Build Tool**: GPRbuild
- **RAM**: 512 MB
- **Disk**: 50 MB

### Optional Requirements

- **SPARK**: GNATprove (for formal verification)
- **Nix**: For reproducible builds
- **Just**: Command runner (recommended)

## Platform-Specific Installation

### Linux (Debian/Ubuntu)

```bash
# Install GNAT and GPRbuild
sudo apt update
sudo apt install gnat gprbuild

# Verify installation
gnat --version
gprbuild --version

# Clone and build
git clone https://github.com/Hyperpolymath/airborne-submarine-squadron.git
cd airborne-submarine-squadron
gprbuild -P submarine_squadron.gpr
./bin/main
```

### Linux (Fedora/RHEL)

```bash
# Install GNAT
sudo dnf install gcc-gnat gprbuild

# Clone and build
git clone https://github.com/Hyperpolymath/airborne-submarine-squadron.git
cd airborne-submarine-squadron
gprbuild -P submarine_squadron.gpr
./bin/main
```

### Linux (Arch)

```bash
# Install GNAT
sudo pacman -S gcc-ada gprbuild

# Clone and build
git clone https://github.com/Hyperpolymath/airborne-submarine-squadron.git
cd airborne-submarine-squadron
gprbuild -P submarine_squadron.gpr
./bin/main
```

### macOS

#### Option 1: Nix (Recommended)

```bash
# Install Nix
sh <(curl -L https://nixos.org/nix/install)

# Enable flakes
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

# Clone and run
git clone https://github.com/Hyperpolymath/airborne-submarine-squadron.git
cd airborne-submarine-squadron
nix run
```

#### Option 2: Homebrew + AdaCore

```bash
# Install GCC with Ada support
brew install gcc

# Download AdaCore GNAT Community Edition
# Visit: https://www.adacore.com/download
# Follow installation instructions

# Clone and build
git clone https://github.com/Hyperpolymath/airborne-submarine-squadron.git
cd airborne-submarine-squadron
gprbuild -P submarine_squadron.gpr
./bin/main
```

### Windows (Native)

#### Option 1: AdaCore GNAT Community

1. Download GNAT Community Edition from [AdaCore](https://www.adacore.com/download)
2. Run the installer
3. Add GNAT to PATH:
   ```cmd
   set PATH=%PATH%;C:\GNAT\2024\bin
   ```

4. Clone and build:
   ```cmd
   git clone https://github.com/Hyperpolymath/airborne-submarine-squadron.git
   cd airborne-submarine-squadron
   gprbuild -P submarine_squadron.gpr
   bin\main.exe
   ```

#### Option 2: MSYS2

```bash
# In MSYS2 terminal
pacman -S mingw-w64-x86_64-gcc-ada

# Clone and build
git clone https://github.com/Hyperpolymath/airborne-submarine-squadron.git
cd airborne-submarine-squadron
gprbuild -P submarine_squadron.gpr
./bin/main
```

### Windows (WSL2)

```bash
# Follow Linux (Ubuntu) instructions
sudo apt install gnat gprbuild
git clone https://github.com/Hyperpolymath/airborne-submarine-squadron.git
cd airborne-submarine-squadron
gprbuild -P submarine_squadron.gpr
./bin/main
```

### BSD (FreeBSD)

```bash
# Install GNAT
pkg install lang/gcc13-devel gprbuild

# Clone and build
git clone https://github.com/Hyperpolymath/airborne-submarine-squadron.git
cd airborne-submarine-squadron
gprbuild -P submarine_squadron.gpr
./bin/main
```

## Building from Source

### Standard Build

```bash
# Clone repository
git clone https://github.com/Hyperpolymath/airborne-submarine-squadron.git
cd airborne-submarine-squadron

# Build (debug mode)
gprbuild -P submarine_squadron.gpr -XMODE=debug

# Build (release mode)
gprbuild -P submarine_squadron.gpr -XMODE=release

# Run
./bin/main
```

### Using Just (Recommended)

```bash
# Install just
cargo install just
# OR
brew install just
# OR
apt install just

# Build
just build

# Run
just run

# Run tests
just test

# Full verification
just verify
```

### Nix Build

```bash
# One-time build
nix build

# Run directly
nix run

# Development shell
nix develop
```

## Verification (Optional)

### SPARK Formal Verification

If you have GNATprove installed:

```bash
# Run SPARK verification
gnatprove -P submarine_squadron.gpr --level=2 --mode=flow

# Full proof
gnatprove -P submarine_squadron.gpr --level=4 --mode=all
```

### Running Tests

```bash
# Using just
just test

# Manual
gprbuild -P tests/test_submarine.gpr
./bin/test_submarine
```

## Troubleshooting

### "gprbuild: command not found"

**Solution**: Install GPRbuild:
```bash
# Debian/Ubuntu
sudo apt install gprbuild

# Fedora
sudo dnf install gprbuild

# Arch
sudo pacman -S gprbuild
```

### "gnat: command not found"

**Solution**: Install GNAT compiler:
```bash
# Debian/Ubuntu
sudo apt install gnat

# Fedora
sudo dnf install gcc-gnat

# Arch
sudo pacman -S gcc-ada
```

### Compilation Errors: "gnat2022 not supported"

**Solution**: Update to GNAT 13.0 or later:
```bash
# Check version
gnat --version

# If < 13.0, install newer version or use Nix
nix develop
```

### Permission Denied on ./bin/main

**Solution**: Make executable:
```bash
chmod +x bin/main
./bin/main
```

### Nix Flakes Not Enabled

**Solution**: Enable experimental features:
```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

## Development Setup

### Recommended Tools

- **Editor**: VS Code with Ada extension, GNAT Studio, Vim with ada-vim, Emacs with ada-mode
- **Debugger**: GDB with Ada support
- **Version Control**: Git
- **Build Runner**: Just

### IDE Setup: VS Code

1. Install VS Code
2. Install "Ada" extension by AdaCore
3. Open project folder
4. Configure tasks.json:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Build",
      "type": "shell",
      "command": "gprbuild -P submarine_squadron.gpr",
      "group": {
        "kind": "build",
        "isDefault": true
      }
    }
  ]
}
```

### IDE Setup: GNAT Studio

```bash
# Install GNAT Studio (included with GNAT Community)
gnatstudio submarine_squadron.gpr
```

## Uninstallation

### Remove Built Artifacts

```bash
just clean
# OR
rm -rf obj bin
```

### Complete Removal

```bash
# Remove project
rm -rf airborne-submarine-squadron

# Remove GNAT (if no longer needed)
# Debian/Ubuntu
sudo apt remove gnat gprbuild

# Fedora
sudo dnf remove gcc-gnat gprbuild
```

## Additional Resources

- **Documentation**: [docs/](docs/)
- **Contributing**: [CONTRIBUTING.md](CONTRIBUTING.md)
- **Security**: [SECURITY.md](SECURITY.md)
- **Issues**: [GitHub Issues](https://github.com/Hyperpolymath/airborne-submarine-squadron/issues)

## Getting Help

- **GitHub Discussions**: [Discussions](https://github.com/Hyperpolymath/airborne-submarine-squadron/discussions)
- **Matrix**: `#airborne-submarine:matrix.org`
- **IRC**: `#airborne-submarine` on Libera.Chat

---

**Happy Flying (and Diving)!** 🌊✈️

