{
  description = "A (not) very basic flake";

  nixConfig = {
    extra-substituters = [ "https://playit-nixos-module.cachix.org" ];
    extra-trusted-public-keys = [ "playit-nixos-module.cachix.org-1:22hBXWXBbd/7o1cOnh+p0hpFUVk9lPdRLX3p5YSfRz4=" ];
  }; 

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:MarceColl/zen-browser-flake";
    stylix.url = "github:danth/stylix/release-24.11";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nix-gaming, nix-flatpak, home-manager, zen-browser, stylix, ... } @ inputs: 
  let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
      zen-browser = inputs.zen-browser.packages.${system};
      pkgs-gaming = inputs.nix-gaming.packages.${system};
  in
  {
    homeConfigurations = {
      "kinvp" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [ 
          ./home.nix
          stylix.homeManagerModules.stylix
          nix-flatpak.homeManagerModules.nix-flatpak
        ];
        extraSpecialArgs = {
          inherit pkgs;
          inherit pkgs-unstable;
          inherit pkgs-gaming;
          inherit zen-browser;
        };
      };
    };
    nixosConfigurations.nixos = lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
      ];
      specialArgs = {
        inherit inputs;
        inherit pkgs-unstable;
      };
    };
  };
}
