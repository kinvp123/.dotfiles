{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, self, catppuccin, ... } @ inputs: 
  let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
      zen-browser = inputs.zen-browser.packages.${system};
  in
  {
    homeConfigurations = {
      "kinvp" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        modules = [ 
          ./home.nix
          catppuccin.homeManagerModules.catppuccin 
        ];
        extraSpecialArgs = {
          inherit pkgs-unstable;
          inherit zen-browser;
        };
      };
    };
    nixosConfigurations.nixos = lib.nixosSystem {
      inherit system;
      modules = [ ./configuration.nix ];
      specialArgs = {
        inherit inputs;
        inherit pkgs-unstable;
      };
    };
  };
}
