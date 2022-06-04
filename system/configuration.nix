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

  #nixpkgs.config.packageOverrides = pkgs:
  #  pkgs.lib.recursiveUpdate pkgs {
  #    linuxKernel.kernels.linux_5_18 = pkgs.linuxKernel.kernels.linux_5_18.override {
  #  extraConfig = ''
  #    KGDB y
  # '';
  #    };
  # };
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_5_18;
  # boot.kernelModules = ["vmwgfx"];
  boot.binfmt.emulatedSystems = ["wasm32-wasi" "aarch64-linux"];
  boot.kernel.sysctl = {
    "vm.swappiness" = 0;
  };
  boot.cleanTmpDir = true;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 4;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  hardware = {
    uinput.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  networking.hostName = "anya"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";
  virtualisation = {
    #vmware.guest.enable = true;
    vmware.guest.headless = true;
    docker.enable = false;
    #docker.autoPrune.enable = true;
    #docker.autoPrune.dates = "weekly";
    docker.rootless.enable = true;
    docker.rootless.setSocketVariable = true;
    #podman.enable = true;
    #podman.dockerCompat = true;
    #podman.dockerSocket.enable = true;
    #podman.defaultNetwork.dnsname.enable = true;
  };
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking = {
    useDHCP = false;
    #tcpcrypt.enable = true;
    enableIPv6 = true;
    interfaces.ens33.useDHCP = true;
    # networking.firewall.checkReversePath = "loose";
    networkmanager.enable = true;
  };
  # enable the tailscale daemon; this will do a variety of tasks:j  # 1. create the TUN network devicej  # 2. setup some IP routes to route through the TUN
  services = {
    # tailscale = {enable = true;};
    resolved.enable = true;
    gnome = {
      gnome-keyring.enable = true;
      gnome-remote-desktop.enable = true;
    };
  };
  networking.useNetworkd = false;
  # run while the tailscale service is running.
  networking.interfaces.tailscale0.useDHCP = lib.mkDefault true;

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
    (nerdfonts.override {fonts = ["JetBrainsMono"];})
  ];

  location.provider = "geoclue2";
  # Enable the X11 windowing system.
  services.xserver.enable = false;

  services.vscode-server.enable = true;

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };
  environment = {
    systemPackages = with pkgs; [
      vmfs-tools
      bintools-unwrapped
      polkit_gnome
      alsa-utils
      pamixer
    ];

    pathsToLink = [
      #"${pkgs.xorg.libxcb}/lib/"
      "/libexec"
    ];
    # default libc, available graphene-hardened, jemalloc mimalloc, scudo
    memoryAllocator.provider = "libc";
    homeBinInPath = true;
    localBinInPath = true;
    #noXlibs = true;
    variables = {
      EDITOR = "nvim";
    };
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
  nixpkgs = {
    config.allowUnfree = true;
  };
  services.xserver.videoDrivers = ["modesetting"];
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

  programs = {
    ccache.enable = true;
    xwayland.enable = false;
    sway = {
      enable = true;
      wrapperFeatures = {
        base = true;
        gtk = true; # so that gtk works properly
      };
    };
    mtr.enable = true;
    nix-ld.enable = true;
    plotinus.enable = true;
  };
  # enable xdg desktop integration https://github.com/flatpak/xdg-desktop-portal/blob/master/README.md
  xdg = {
    autostart.enable = true;
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

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
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
  system.stateVersion = "22.11"; # Did you read the comment?
  nix = {
    settings = {
      # show-trace = true;
    };
    autoOptimiseStore = true;
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
