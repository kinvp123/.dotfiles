{ config, flake-inputs, pkgs, ... }:
{
  imports =[ ./hardware-configuration.nix ];

  # Bootloader.
  boot = {
    plymouth = {
      enable = true;
      theme = "fade-in";
    };
    # Enable "Silent Boot"
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    # Hide the OS choice for bootloaders. Press any key to bring it up.
    loader = {
      timeout = 2;
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
      };
    };

	  initrd.kernelModules = [ "amdgpu" ];
    kernel.sysctl."kernel.sysrq" = 502; # For CoreCtrl
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Enable networking
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    nameservers = ["8.8.8.8" "8.8.4.4"];
    firewall.allowedTCPPorts = [ 22 ];
  };

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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

    inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      bamboo
      ];
    };
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

    openssh.enable = true;
    displayManager.sddm.enable = true;

    flatpak = {
      enable = true;
	    packages = [
      { # Sober
        flatpakref = "https://sober.vinegarhq.org/sober.flatpakref";
        sha256 = "1pj8y1xhiwgbnhrr3yr3ybpfis9slrl73i0b1lc9q89vhip6ym2l";
      }

      # MAIN REPO
      "com.dec05eba.gpu_screen_recorder"
      "io.github.everestapi.Olympus"
      ];
    };
    # Volatile jctl logging, limited file size, speed up boot time with the tradeoff being no previous boot logs.
    journald.extraConfig = "RuntimeMaxUse=32M SystemMaxUse==128M";
  };

  systemd = {
  user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
  services.NetworkManager-wait-online.enable = false;
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
    hyprland.enable = true;
    gamemode.enable = true;
    corectrl = {
      enable = true;
      gpuOverclock.enable = true;
  };
};
  
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [ steam-run fuse fuse3 jdk obsidian ];

  system.stateVersion = "24.05"; # Control the system states (settings filesys etc), recommended to keep at 24.05
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "kinvp" ];

    substituters = ["https://nix-gaming.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];

    auto-optimise-store = true;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };
}
