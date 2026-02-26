{

  description = "My flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          # ./modules/virtual_profiles.nix
          home-manager.nixosModules.home-manager {
            # home-manager.useGlobalPkgs = true;
            # home-manager.useUserPackages = true;
            home-manager.users.sacha = import ./home.nix;
          }
        ];
      };
    };
    # homeConfigurations = {
    #   sacha = home-manager.lib.homeManagerConfiguration {
    #     inherit pkgs;
    #     modules = [ 
    #         ./home.nix 
    #     ];
    #   }; 
    # };
  };

}
