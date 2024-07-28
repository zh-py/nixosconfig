{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    #xremap-flake.url = "github:xremap/nix-flake";
  };

  outputs = inputs@{ nixpkgs, home-manager, nur, ... }: {
    nixosConfigurations = {
      py = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nur.nixosModules.nur
          # This adds a nur configuration option.
          # Use `config.nur` for packages like this:
          # ({ config, ... }: {
          #   environment.systemPackages = [ config.nur.repos.mic92.hello-nur ];
          # })
          #inputs.xremap-flake.nixosModules.default
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.py = import ./home.nix;
            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };
  };
}
