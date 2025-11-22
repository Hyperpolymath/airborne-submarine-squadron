#!/usr/bin/env bash
# =================================================================
# Build Script - Airborne Submarine Squadron
# =================================================================
#
# Simple build script for platforms without 'just' installed
#
# Usage:
#   ./build.sh          # Build debug version
#   ./build.sh release  # Build release version
#   ./build.sh clean    # Clean build artifacts
#   ./build.sh test     # Run tests
# =================================================================

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Print colored message
info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check for required tools
check_deps() {
    info "Checking dependencies..."

    if ! command -v gprbuild &> /dev/null; then
        error "gprbuild not found. Please install GNAT Ada compiler."
        echo "  Debian/Ubuntu: sudo apt install gprbuild"
        echo "  Fedora: sudo dnf install gprbuild"
        echo "  Arch: sudo pacman -S gprbuild"
        exit 1
    fi

    if ! command -v gnat &> /dev/null; then
        error "gnat not found. Please install GNAT Ada compiler."
        exit 1
    fi

    info "Dependencies OK (gnat $(gnat --version | head -1))"
}

# Build debug version
build_debug() {
    info "Building debug version..."
    mkdir -p obj bin
    gprbuild -P submarine_squadron.gpr -XMODE=debug
    info "Build complete: bin/main"
}

# Build release version
build_release() {
    info "Building release version..."
    mkdir -p obj bin
    gprbuild -P submarine_squadron.gpr -XMODE=release
    info "Release build complete: bin/main"
}

# Clean build artifacts
clean() {
    info "Cleaning build artifacts..."
    rm -rf obj bin
    info "Clean complete"
}

# Run tests
run_tests() {
    info "Running tests..."

    # Build and run test suite
    if [ -f tests/test_submarine.gpr ]; then
        gprbuild -P tests/test_submarine.gpr
        ./bin/test_submarine
    else
        warn "Test suite not yet configured"
    fi
}

# Run the game
run() {
    if [ ! -f bin/main ]; then
        warn "Binary not found, building first..."
        build_debug
    fi

    info "Running Airborne Submarine Squadron..."
    ./bin/main
}

# Main script logic
case "${1:-build}" in
    build|debug)
        check_deps
        build_debug
        ;;
    release)
        check_deps
        build_release
        ;;
    clean)
        clean
        ;;
    test)
        check_deps
        run_tests
        ;;
    run)
        check_deps
        run
        ;;
    --help|-h)
        echo "Usage: $0 [command]"
        echo ""
        echo "Commands:"
        echo "  build, debug   Build debug version (default)"
        echo "  release        Build release version"
        echo "  clean          Clean build artifacts"
        echo "  test           Run test suite"
        echo "  run            Run the game"
        echo "  --help, -h     Show this help"
        ;;
    *)
        error "Unknown command: $1"
        echo "Run '$0 --help' for usage"
        exit 1
        ;;
esac
