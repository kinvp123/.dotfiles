{ zen-browser, pkgs-unstable, config, pkgs, lib, ... }:

{
  imports = [ 
    ./modules/imports.nix
  ];

  home.username = "kinvp";
  home.homeDirectory = "/home/kinvp";
  home.stateVersion = "24.05";

  home.packages = (with pkgs; [
    ## [CORE] ##
    wget
    unzip
    icu
    gh

    ## [THEMING] ##	  
    pfetch-rs
    catppuccin-gtk
    lolcat
    swww

    ## [FUNCTIONS] ##
    bitwarden
    tofi
    waybar
    pavucontrol
    zen-browser.default # [default, specific, generic]
    arrpc
    tree
    ffmpeg
    jq
    vesktop
    flameshot

    ## [I3] ##
    i3blocks
    i3status
    i3-gaps
    dmenu
    feh

    ## [EXTRAS] ##
    # Remember to wrap overrides in ()
    (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
  ]) ++

  ## [UNSTABLE] ##
  (with pkgs-unstable; [
    prismlauncher
  ]);

#  (with pkgs-gaming; [
#    osu-lazer-bin
#  ]);

  programs.home-manager.enable = true;
  services.arrpc.enable = true;
}

