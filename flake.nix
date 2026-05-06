{
  description = "Multi-host config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... } @inputs:
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
