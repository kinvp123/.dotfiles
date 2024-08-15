{ config, pkgs, ... }:
{
  qt = {
    enable = true;
    platformTheme = "qtct";
    style.name = "kvantum";
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
    General.theme = "Catppuccin-Mocha-Mauve";
  };
}