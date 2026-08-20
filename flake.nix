{
  description = "Multi-host config";

  nixConfig = {
    extra-substituters = [
      "https://attic.xuyh0120.win/lantian"
    ];
    extra-trusted-public-keys = [
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };

  outputs = { self, nixpkgs, home-manager, nix-cachyos-kernel, ... } @inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      # Generate configs
      mkHost = hostName: userName: lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs hostName userName; };

        modules = [
          ./hosts/${hostName}

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs hostName userName; };
            home-manager.users.${userName} = import ./users/${userName}/hosts/${hostName}.nix;
          }

          (
            { pkgs, ... }:
            {
              nixpkgs.overlays = [
                nix-cachyos-kernel.overlays.pinned
              ];
              nix.settings = {
                extra-substituters = [
                  "https://attic.xuyh0120.win/lantian"
                ];
                extra-trusted-public-keys = [
                  "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
                ];
                trusted-users = [ "root" "@wheel" ];
              };
            }
          )
        ];
      };
    in {
      nixosConfigurations = {
        #                      system           user
        ThinkpadT480  = mkHost "ThinkpadT480" "sacha";
        Fujitsu       = mkHost "Fujitsu"      "sacha";
        Server0       = mkHost "Server0"      "nixserver";
      };
    };
}
