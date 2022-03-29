{ config, pkgs, overlays, ... }: {

  home.packages = with pkgs; [
    dua
    python3
    rclone
    fzf
    nushell
    ctags
    sqlite
    fd
    ripgrep
    git
    font-awesome
    gnumake
    unzip
    cached-nix-shell
    helix
    usbutils
    home-manager
    open-vm-tools
    gnupg
    libu2f-host
    opensc
    pcsctools
    gh
    #gcc
    mosh
    clang_multi
    deno
    file
    enchant
    gnome3.adwaita-icon-theme
    gnome3.gnome-settings-daemon
    sway
    swaylock
    bitwarden
    bitwarden-cli
    emacsPgtkGcc
    wget
    xorg.xprop
    xorg.xwininfo
    thefuck
    rustup
    firefox
    rust-analyzer
    zoxide
    zellij
    foot
    lapce
    pciutils
    fnm
  ];

  # stdenv = pkgs.clangStdenv;

  services = {
    lorri.enable = true;
    gpg-agent = { enable = true; };
  };
  programs = {
    neovim.plugins = [
    {
      plugin = pkgs.vimPlugins.sqlite-lua;
      config = "let g:sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.so'";
    }
];
    git = {
      enable = true;
      userName = "Suraj Ghimire";
      userEmail = "suraj@ghishadow.com";
    };
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
      nix-direnv = { enable = true; };
    };
  };
}

