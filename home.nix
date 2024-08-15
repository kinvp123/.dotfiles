{ config, pkgs, ... }:


let 
  unstableTarball = builtins.fetchTarball {
    url = https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
  };
in {
  imports = [ 
  ./modules/hyprland/hyprcfg.nix
  ./modules/theming/gtkcfg.nix
  ./modules/theming/qtcfg.nix
  ];

  home.username = "kinvp";
  home.homeDirectory = "/home/kinvp";

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
	  pfetch-rs
	  mangohud
	  wget
	  unzip
    protonvpn-gui
    fastfetch
    lolcat
    catppuccin-gtk
    icu
    bitwarden
    tofi
    waybar
    unstable.ungoogled-chromium
    unstable.prismlauncher
    unstable.tetrio-desktop
    unstable.osu-lazer-bin
  ];

  xdg.configFile = { # For use with ~/.config/ files
#    "waybar/config.jsonc".source = ./modules/waybar/config.jsonc;
#    "waybar/style.css".source = ./modules/waybar/style.css;
  };

  home.file = { # For use with ~/ files

  };
  
  home.sessionVariables = {

  };

  gtk = {
    enable = true;
  };

  programs = {
    vscode = {
		  enable = true;
		  package = pkgs.vscodium;
		  extensions = with pkgs.vscode-extensions; [];
	  };
    git = {
      enable = true;
      aliases = {
        cl = "clone";
        cm = "commit";
        co = "checkout";
        st = "status";
      };
      userName = "kinvp123";
      userEmail = "kinvp123@proton.me";
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        nixsw = "sudo nixos-rebuild switch --flake $HOME/.dotfiles/";
        homesw = "home-manager switch --flake $HOME/.dotfiles/ --impure";
        clear = "clear && pfetch";
        };
    };
    kitty = {
      enable = true;
      catppuccin.enable = true;
      shellIntegration.enableZshIntegration = true;
      settings = {
        confirm_os_window_close = 0;
      };
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
      catppuccin.enable = true;
      fileWidgetOptions = [
        "--preview 'head {}' --exclude ~/.steam --exclude ~/.local/share/steam"
      ];
    };
    home-manager.enable = true;
    alacritty.enable = true;
  };  
}

