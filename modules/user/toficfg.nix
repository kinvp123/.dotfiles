{config, pkgs, ...}:
{
  xdg.configFile."tofi/config".source = ../storage/configFiles/config;
}