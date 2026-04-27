{
  description = "A startup basic MoonBit project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    devshell.url = "github:numtide/devshell";
    moonbit-overlay.url = "github:moonbit-community/moonbit-overlay";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devshell.flakeModule
      ];

      perSystem = { inputs', system, pkgs, ... }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [
            inputs.moonbit-overlay.overlays.default
            # On aarch64-darwin, tinycc is broken and fails to build.
            # The moonbit-overlay references it via eager string interpolation
            # even for the 'latest' version (which bundles its own tcc).
            # Provide a stub so evaluation succeeds.
            (final: prev:
              prev.lib.optionalAttrs (system == "aarch64-darwin") {
                tinycc = prev.writeScriptBin "tcc" "echo 'stub tcc for aarch64-darwin'";
              }
            )
          ];
        };

        devshells.default = {
            packages = with pkgs; [
              moonbit-bin.moonbit.latest
            ];
          };
      };

      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
    };
}
