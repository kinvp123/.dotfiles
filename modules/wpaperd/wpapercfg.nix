{config, pkgs, ...}:
{
  programs.wpaperd.enable = true;
  programs.wpaperd.settings = {
    HDMI-A-1 = {
      path = "~/.dotfiles/modules/wpaperd/wallpaper";
      sorting = "random";
      duration = "15m";
    };
    DP-4 = {
      path = "~/.dotfiles/modules/wpaperd/wallpaper";
      sorting = "random";
      duration = "15m";
    };
  };
}