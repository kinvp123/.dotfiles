{config, pkgs, nix-flatpak, ...}:
{
  services.flatpak.packages = [
    { # Sober
      flatpakref = "https://sober.vinegarhq.org/sober.flatpakref";
      sha256 = "1pj8y1xhiwgbnhrr3yr3ybpfis9slrl73i0b1lc9q89vhip6ym2l";
    }

    ## MAIN REPO
    "com.dec05eba.gpu_screen_recorder"
    "io.github.everestapi.Olympus"
  ];
}