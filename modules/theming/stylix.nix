{config, pkgs, inputs, ...}:
{
  stylix = {
    enable = true;
    image = ../storage/wallpaper/wallhaven-r2jzem.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";
    fonts = {
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = config.stylix.fonts.monospace;
    };
  };
}