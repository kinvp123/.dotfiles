{config, pkgs, ...}:
{
  xdg.configFile."tofi/config".source = ./config;
}