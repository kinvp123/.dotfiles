{ config, pkgs, lib, ... }:
{
  xdg.configFile."waybar/config.jsonc".source = ../storage/configFiles/config.jsonc;
  xdg.configFile."waybar/style.css".source = ../theming/waybarStyle.css;
}