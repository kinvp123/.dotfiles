{pkgs, config, lib, ...}:
{
  xsession.windowManager.i3.enable = true;
  xdg.configFile."i3/config".source = lib.mkForce ../storage/configFiles/i3Config;
  xdg.configFile."i3status/config".source  = lib.mkForce ../storage/configFiles/i3stConfig;
}