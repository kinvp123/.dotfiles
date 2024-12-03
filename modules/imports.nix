{config, pkgs, ...}:
{
  imports = [
    ./core/terminals.nix
    ./theming/gtkqt.nix
    ./user/git.nix
    ./user/vscode.nix
    ./user/hyprcfg.nix
    ./user/toficfg.nix
    ./user/waybarcfg.nix
    ./user/wpapercfg.nix
    ./user/i3cfg.nix
  ];
}