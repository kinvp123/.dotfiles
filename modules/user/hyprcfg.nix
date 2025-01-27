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
          };

          exec-once = [
            "waybar"
            "firefox"
            "wpaperd -d"
          ];

          bind = [
            "SUPER, Return, exec, kitty"
            "SUPER, Q, killactive"
            "SUPER, D, exec, $(tofi-drun --font ~/.dotfiles/modules/storage/fonts/Nunito-Regular.ttf)"
            "SUPER_SHIFT, D, exec, $(tofi-run --font ~/.dotfiles/modules/storage/fonts/Nunito-Regular.ttf)"
            "CTRL_ALT, Backspace, exit"

            "SUPER, 1, workspace, 1"
            "SUPER, 2, workspace, 2"
            "SUPER, 3, workspace, 3"
            "SUPER, 4, workspace, 4"
            "SUPER, 5, workspace, 5"
            "SUPER, 6, workspace, 6"
            "SUPER, 7, workspace, 7"
            "SUPER, 8, workspace, 8"
            "SUPER, 9, workspace, 9"
            "SUPER, 0, workspace, 10"

            "SUPER_SHIFT, 1, movetoworkspacesilent, 1"
            "SUPER_SHIFT, 2, movetoworkspacesilent, 2"
            "SUPER_SHIFT, 3, movetoworkspacesilent, 3"
            "SUPER_SHIFT, 4, movetoworkspacesilent, 4"
            "SUPER_SHIFT, 5, movetoworkspacesilent, 5"
            "SUPER_SHIFT, 6, movetoworkspacesilent, 6"
            "SUPER_SHIFT, 7, movetoworkspacesilent, 7"
            "SUPER_SHIFT, 8, movetoworkspacesilent, 8"
            "SUPER_SHIFT, 9, movetoworkspacesilent, 9"
            "SUPER_SHIFT, 0, movetoworkspacesilent, 10"

            "SUPER, Space, togglefloating"

            "SUPER, J, movefocus, l"
            "SUPER, K, movefocus, d"
            "SUPER, L, movefocus, r"
            "SUPER, I, movefocus, u"

            ", Print, exec, hyprshot -m region -o ~/Pictures -s"
            "SUPER, Print, exec, hyprshot -m output -o ~/Pictures -s"
            "SUPER_SHIFT, Print, exec, hyprshot -m output -o ~/Pictures -s"
          ];

          bindm = [
            "SUPER, mouse:272, movewindow"
            "SUPER, mouse:273, resizewindow"
          ];
        };
      };
    };
  };
}