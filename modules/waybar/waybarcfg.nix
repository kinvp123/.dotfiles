{config, pkgs, ...}:
{
  xdg.configHome."waybar/config.jsonc".source = ./config.jsonc;
  xdg.configHome."waybar/style.css".source = ./style.css;
}