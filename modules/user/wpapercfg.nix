{config, pkgs, ...}:
{
  programs.wpaperd.enable = true;
  programs.wpaperd.settings = {
    HDMI-A-1 = {
      path = "~/.dotfiles/modules/storage/wallpaper";
      sorting = "random";
      duration = "15m";
    };
    DP-4 = {
      path = "~/.dotfiles/modules/storage/wallpaper";
      sorting = "random";
      duration = "15m";
    };
  };
  # TODO: to move wallpapers into the actual directory the config file lies.
}