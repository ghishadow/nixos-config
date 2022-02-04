{ config, pkgs, overlays, ... }: {

  home.packages = [
    pkgs.fzf
    pkgs.ctags
    pkgs.fd
    pkgs.ripgrep
    pkgs.git
    pkgs.clang
    pkgs.wget
    pkgs.font-awesome
    pkgs.gnumake
    pkgs.unzip
    pkgs.cached-nix-shell
    pkgs.foot
    pkgs.fish
    pkgs.usbutils
    pkgs.home-manager
    pkgs.vscode
    pkgs.open-vm-tools
    pkgs.gnupg
    pkgs.libu2f-host
    pkgs.opensc
    pkgs.pcsctools
    pkgs.gh
    pkgs.nodejs
    pkgs.vulkan-tools
    pkgs.file
    pkgs.bind
    pkgs.dmenu
    pkgs.helix
    pkgs.gnome3.adwaita-icon-theme
    pkgs.gnomeExtensions.appindicator
    pkgs.gnome3.gnome-settings-daemon
    pkgs.sway
    # pkgs.emacsPgtkGcc
  ];

  services = {
    lorri.enable = true;
    gpg-agent = {
      enable = true;
      # enableSSHSupport = true;
    };
  };
  programs = {
  # sway = {
  #   enable = true;
  #   wrapperFeatures.gtk = true; # so that gtk works properly
  #   extraPackages = with pkgs; [
  #     swaylock
  #     swayidle
  #     xwayland
  #     kanshi
  #     fuzzel # Dmenu is the default in the config but i recommend wofi since its wayland native
  #   ];
  # };
    bat.enable = true;
    gpg.enable = true;
    fzf.enable = true;
    jq.enable = true;
    command-not-found.enable = true;
    dircolors.enable = true;
    htop.enable = true;
    info.enable = true;
    exa.enable = true;
    direnv = {
      enable = true;
      nix-direnv = {
      enable = true;
      };
  };
};
}

