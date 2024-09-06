{ config, inputs, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot = {
  	loader.systemd-boot.enable = true;
  	loader.efi.canTouchEfiVariables = true;
	  initrd.kernelModules = [ "amdgpu" ];
    kernelParams = [
      "quiet"
      "splash"
    ];
  };
  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking = {
    networkmanager.enable = true;
    nameservers = ["1.1.1.1" "1.0.0.1"];
  };

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "vi_VN";
    LC_IDENTIFICATION = "vi_VN";
    LC_MEASUREMENT = "vi_VN";
    LC_MONETARY = "vi_VN";
    LC_NAME = "vi_VN";
    LC_NUMERIC = "vi_VN";
    LC_PAPER = "vi_VN";
    LC_TELEPHONE = "vi_VN";
    LC_TIME = "vi_VN";
  };

  services = {
	  xserver = {
		  enable = true;
		  xkb.layout = "us";
		  xkb.variant = "";
	  };

	  pipewire = {
    	enable = true;
    	alsa.enable = true;
    	alsa.support32Bit = true;
    	pulse.enable = true;
	  };
	  flatpak.enable = true;
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kinvp = {
    isNormalUser = true;
    description = "kin";
    extraGroups = [ "networkmanager" "wheel" "gamemode" ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  };

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    };
    gamemode.enable = true;

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [ steam-run fuse fuse3 xdg-desktop-portal-hyprland];

  system.stateVersion = "24.05"; # Control the system states (settings filesys etc), recommended to keep at 24.05
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
