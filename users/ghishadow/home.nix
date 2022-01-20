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
    pkgs.wezterm
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
    pkgs.gnome3.adwaita-icon-theme
    pkgs.gnomeExtensions.appindicator
    pkgs.gnome3.gnome-settings-daemon
    pkgs.emacsPgtkGcc
  ];

  services = {
    lorri.enable = true;
    gpg-agent = {
      enable = true;
      # enableSSHSupport = true;
    };
  };
  programs = {
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

