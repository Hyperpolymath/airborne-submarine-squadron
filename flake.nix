# =================================================================
# Nix Flake - Reproducible Builds for Airborne Submarine Squadron
# =================================================================
#
# This flake provides reproducible builds and development environments
# for the Airborne Submarine Squadron game.
#
# Usage:
#   nix build          # Build the project
#   nix run            # Run the game
#   nix develop        # Enter development shell
#   nix flake check    # Run tests and verification
# =================================================================

{
  description = "Airborne Submarine Squadron - RSR-compliant 2D flying submarine game";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        # GNAT Ada compiler
        gnat = pkgs.gnat13;

        # Build the game
        submarine-squadron = pkgs.stdenv.mkDerivation {
          pname = "airborne-submarine-squadron";
          version = "0.1.0";

          src = ./.;

          nativeBuildInputs = [
            gnat
            pkgs.gprbuild
          ];

          buildPhase = ''
            mkdir -p obj bin
            gprbuild -P submarine_squadron.gpr -XMODE=release
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp bin/main $out/bin/submarine-squadron
          '';

          meta = with pkgs.lib; {
            description = "2D flying submarine game written in Ada 2022";
            homepage = "https://github.com/Hyperpolymath/airborne-submarine-squadron";
            license = [ licenses.mit ]; # Dual MIT + Palimpsest
            maintainers = [ ];
            platforms = platforms.unix;
          };
        };

      in
      {
        # Default package
        packages.default = submarine-squadron;
        packages.submarine-squadron = submarine-squadron;

        # Development shell
        devShells.default = pkgs.mkShell {
          buildInputs = [
            gnat
            pkgs.gprbuild
            pkgs.just
            pkgs.git
            pkgs.gnumake
          ];

          shellHook = ''
            echo "==================================================="
            echo "  Airborne Submarine Squadron Dev Environment"
            echo "  Ada 2022 | Type-Safe | Memory-Safe"
            echo "==================================================="
            echo ""
            echo "Available commands:"
            echo "  just build    - Build the project"
            echo "  just run      - Run the game"
            echo "  just test     - Run tests"
            echo "  just verify   - SPARK verification"
            echo ""
            echo "GNAT version: $(gnat --version | head -1)"
            echo ""
          '';
        };

        # Apps
        apps.default = {
          type = "app";
          program = "${submarine-squadron}/bin/submarine-squadron";
        };

        # Checks (tests and verification)
        checks = {
          build = submarine-squadron;

          # Additional checks can be added here
          # format-check = ...
          # lint-check = ...
        };
      }
    );
}
