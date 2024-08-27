{ pkgs-unstable, config, pkgs, lib, ... }:

{
  imports = [ 
    ./modules/hyprland/hyprcfg.nix
    ./modules/theming/gtkqt.nix
    ./modules/waybar/waybarcfg.nix
    ./modules/wpaperd/wpapercfg.nix
    ./modules/tofi/toficfg.nix
  ];

  home.username = "kinvp";
  home.homeDirectory = "/home/kinvp";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = (with pkgs; [
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
    pavucontrol
    # Remember to wrap overrides in ()
    (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
  ])
  ++
  (with pkgs-unstable; [
    ungoogled-chromium
    prismlauncher
  ]);

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
        homesw = "NIXPKGS_ALLOW_UNFREE=1 home-manager switch --flake $HOME/.dotfiles/ --impure";
        # ENV_VAR and --impure forced, allowUnfree does not work.
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
    };
    home-manager.enable = true;
    alacritty.enable = true;
    firefox.enable = true;
  };  
}

