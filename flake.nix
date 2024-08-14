{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, self, ... }: {
    homeConfigurations = {
        "kinvp" = home-manager.lib.homeManagerConfiguration {
            # Note: I am sure this could be done better with flake-utils or something
            pkgs = import nixpkgs { system = "x86_64-linux"; };
            modules = [ ./home.nix ];
        };
    };
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86.64-linux";
      modules = [ ./configuration.nix ];
    };
  };
}
