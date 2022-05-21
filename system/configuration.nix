# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./modules/mpv.nix
    ./hardware-configuration.nix
    (fetchTarball {
      url = "https://github.com/msteen/nixos-vscode-server/tarball/master";
      sha256 = "sha256:1cszfjwshj6imkwip270ln4l1j328aw2zh9vm26wv3asnqlhdrak";
    })
  ];

  nixpkgs.config.packageOverrides = pkgs:
    pkgs.lib.recursiveUpdate pkgs {
      linuxKernel.kernels.linux_5_17 = pkgs.linuxKernel.kernels.linux_5_17.override {
        #  extraConfig = ''
        #    KGDB y
        # '';
      };
    };
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_5_17;
  #boot.kernelModules = [ "vmwgfx"];
  # Use the systemd-boot EFI boot loader.
  # environment.pathsToLink = [ "${pkgs.xorg.libxcb}/lib/" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  networking.hostName = "anya"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";
  virtualisation.vmware.guest.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.podman.enable = false;
  virtualisation.podman.dockerSocket.enable = true;
  virtualisation.podman.defaultNetwork.dnsname.enable = true;
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.ens33.useDHCP = true;
  # networking.firewall.checkReversePath = "loose";
  networking.networkmanager.enable = true;

  # enable the tailscale daemon; this will do a variety of tasks:j  # 1. create the TUN network devicej  # 2. setup some IP routes to route through the TUN
  #services.tailscale = {enable = true;};
  services.resolved.enable = true;
  networking.useNetworkd = true;
  # run while the tailscale service is running.
  networking.interfaces.tailscale0.useDHCP = lib.mkDefault true;

  nix.autoOptimiseStore = true;

  environment.variables.EDITOR = "nvim";
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  fonts.fonts = with pkgs; [
    # nerd font
    (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = false;

  # Keyring
  services.gnome.gnome-keyring.enable = true;

  services.vscode-server.enable = true;

  environment = {
    loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
      export WLR_NO_HARDWARE_CURSORS=1
      exec sway
      fi
    '';

    etc = {
      # Put config files in /etc. Note that you also can put these in ~/.config, but then you can't manage them with NixOS anymore!
      #  "xdg/waybar/config".source = ./dotfiles/waybar/config;
      # "xdg/waybar/style.css".source = ./dotfiles/waybar/style.css;
    };
  };
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  services.gnome.core-utilities.enable = false;
  #services.xserver.updateDbusEnvironment = true;
  nixpkgs.config.allowUnfree = true;

  services.xserver.videoDrivers = ["vmware"];
  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  systemd.user.targets.sway-session = {
    description = "Sway compositor session";
    documentation = ["man:systemd.special(7)"];
    bindsTo = ["graphical-session.target"];
    wants = ["graphical-session-pre.target"];
    after = ["graphical-session-pre.target"];
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  services.flatpak.enable = true;
  # Enable sound.
  #sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    wireplumber.enable = true;
    media-session.enable = false;
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };
  #hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ghishadow = {
    isNormalUser = true;
    extraGroups = ["wheel" "video" "audio" "docker" "podman"]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  security.sudo.extraRules = [
    {
      users = ["ghishadow"];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD"]; # "SETENV" # Adding the following could be a good idea
        }
      ];
    }
  ];

  # List packages installed in system profile. To search, run:

  # $ nix search wget

  environment.systemPackages = with pkgs; [open-vm-tools vmfs-tools bintools-unwrapped xorg.xf86videovmware polkit_gnome alsa-utils pamixer];
  environment.pathsToLink = ["/libexec"];
  programs.nix-ld.enable = true;
  programs.plotinus.enable = true;
  #programs.seahorse.enable = true;
  # enable xdg desktop integration https://github.com/flatpak/xdg-desktop-portal/blob/master/README.md
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      gtkUsePortal = true;
      wlr.enable = true;
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
  };
  programs.mtr.enable = true;
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  #services.vmwareGuest.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
}
