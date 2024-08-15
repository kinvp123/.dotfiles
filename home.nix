{ config, pkgs, ... }:


let 
  unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
in {
  imports = [

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
    unstable.ungoogled-chromium
    unstable.prismlauncher
    unstable.tetrio-desktop
    unstable.osu-lazer-bin
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };
  
  home.sessionVariables = {

  };

  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        package = pkgs.hyprland;
        settings = {
          monitor = [
            "HDMI-A-1, 1920x1080@75, 0x0, 1"
            "DP-4, 1920x1080@60, auto, 1"
          ];
          general = {
            gaps_in = 4;
            gaps_out  = 16;
            "col.active_border" = "rgb(f5c2e7) rgb(cba6f7) 45deg";
          };
          bind = [
            "SUPER, Return, exec, kitty"
            "SUPER, Q, killactive"
            "SUPER, D, exec $(tofi-drun)"

            
          ];
        };
      };
    };
  };

  gtk = {
    enable = true;
    catppuccin.enable = true;
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

