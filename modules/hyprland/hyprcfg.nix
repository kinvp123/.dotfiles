{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    hyprshot
    hyprpaper
  ];

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
            "SUPER, D, exec, $(tofi-drun)"
            "SUPER_SHIFT, D, exec, $(tofi-run)"

            ", Print, exec, hyprshot -m region -o ~/Pictures -s"
            "SUPER, Print, exec, hyprshot -m output -o ~/Pictures -s"
            "SUPER_SHIFT, Print, exec, hyprshot -m output -o ~/Pictures -s"
          ];
        };
      };
    };
  };
}