{
  config,
  pkgs,
  overlays,
  ...
}: {
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    XDG_CURRENT_DESKTOP = "sway";
  };

  home.packages = with pkgs; [
    # secret stuff
    libnotify
    libsecret
    gnome.gnome-keyring
    ffmpeg
    yt-dlp
    termusic
    cliphist
    sway-contrib.inactive-windows-transparency
    sway-contrib.grimshot
    grim
    waybar
    sccache
    desktop-file-utils
    openssl
    openssl.dev
    editorconfig-core-c
    gnome.nautilus
    diskonaut
    fuzzel
    dua
    python3
    rclone
    fzf
    nushell
    ctags
    sqlite
    fd
    foot
    ripgrep
    starship
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
    file
    just
    enchant
    gnome3.adwaita-icon-theme
    gnome3.gnome-settings-daemon
    sway
    swaylock
    shellcheck
    bitwarden-cli
    emacsPgtkGcc
    wget
    xorg.xprop
    xorg.xwininfo
    thefuck
    rustup
    firefox-wayland
    rust-analyzer
    zoxide
    zellij
    pciutils
  ];

  # stdenv = pkgs.clangStdenv;

  services = {
    lorri.enable = true;
    gpg-agent = {enable = true;};
  };
  programs = {
    git = {
      enable = true;
      userName = "Suraj Ghimire";
      userEmail = "suraj@ghishadow.com";
      aliases = {gl = "pull";};
      #delta.enable = true;
      #init = {
      #  defaultBranch = "main";
      # };
      lfs = {
        enable = true;
      };
      signing = {
        signByDefault = true;
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG8jIo/7ypSugYtrtCEbtPkxe4Rtt/YELALAoRTKtK28";
      };
      extraConfig = {
        diff.algorithm = "histogram";
        gpg.format = "ssh";
        gpg.ssh.program = "${pkgs.openssh}/bin/ssh-keygen";
        core.pager = "delta";
        core.editor = "${pkgs.helix}/bin/hx";
        init.defaultBranch = "main";
        interactive.diffFilter = "delta --color-only";
        delta.navigate = true;
        merge.conflictstyle = "diff3";
        diff.colorMoved = "default";
      };
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
      nix-direnv = {enable = true;};
    };
  };
}
