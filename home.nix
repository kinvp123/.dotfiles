{ config, pkgs, ... }:


let 
  unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
in {
  imports = [
    <catppuccin/modules/home-manager>
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
        nixsw = "sudo nixos-rebuild switch";
        homesw = "home-manager switch";
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

