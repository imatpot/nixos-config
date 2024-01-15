{ lib, inputs, ... }:

{
  mkHost = { hostname, system, stateVersion, users ? [ ] }:
    lib.nixosSystem {
      inherit system;

      modules = [
        {
          _module.args = {
            inherit inputs hostname system stateVersion;

            # TODO: Find a way to merge with lib generated by lib.nixosSystem
            lib' = lib;
          };
        }

        ../hosts/${hostname}/configuration.nix
        ../hosts/${hostname}/hardware.nix

        inputs.home-manager.nixosModules.home-manager

        (import ../modules/nixos/home-manager.nix {
          inherit lib hostname system stateVersion users;
        })

        (import ../modules/nixos/user-system-configs.nix {
          inherit lib hostname system stateVersion users;
        })
      ];
    };
}
