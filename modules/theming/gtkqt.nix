{config, pkgs, ...}:
{
  gtk = {
    enable = true;
    catppuccin.enable = true;
  };

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.catppuccin.enable = true;
    style.catppuccin.apply = true;
    style.name = "kvantum";
  };
}