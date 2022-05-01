{
  config,
  pkgs,
  overlays,
  ...
}: {
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    XDG_CURRENT_DESKTOP = "sway";
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland";
    WINIT_UNIX_BACKEND = "wayland";
    #MOZ_DISABLE_CONTENT_SANDBOX = 1;
  };

  home.packages = with pkgs; [
    rustup
    stylua
    black
    nodePackages.prettier
    mercurial
    autotiling
    git-ignore
    virt-viewer
    magic-wormhole
    cachix
    wayland
    bind
    helvum
    neovide
    jless
    glow
    asciinema
    sublime4
    # secret stuff
    gnome.gnome-themes-extra
    gtk-engine-murrine
    delta
    gtk_engines
    libtool
    cmake
    libvterm
    gnome.gnome-tweaks
    xdg-utils
    zathura
    libnotify
    meson
    ninja
    lsof
    tokei
    glib
    gtkmm4
    fish
    libsecret
    gnome.gnome-keyring
    gsettings-desktop-schemas
    ffmpeg
    yt-dlp
    termusic
    cliphist
    lazygit
    sway-contrib.inactive-windows-transparency
    sway-contrib.grimshot
    grim
    waybar
    sccache
    desktop-file-utils
    openssl
    editorconfig-core-c
    cinnamon.nemo
    diskonaut
    fuzzel
    dua
    rclone
    nushell
    ctags
    sqlite
    fd
    foot
    ripgrep
    font-awesome
    gnumake
    unzip
    cached-nix-shell
    neovim-nightly
    usbutils
    home-manager
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
    emacsPgtkNativeComp
    wget
    xorg.xprop
    xorg.xwininfo
    thefuck
    # enable when webextension issue is fixed upstream #167785
    firefox-wayland
    rust-analyzer
    zellij
    pciutils
    difftastic
  ];

  #services.vscode-server.enable = true;

  services = {
    lorri.enable = true;
    gpg-agent = {enable = true;};
  };
  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    mcfly = {
      enable = true;
      enableZshIntegration = true;
      enableFuzzySearch = true;
    };
    keychain = {
      enableZshIntegration = true;
      keys = ["id_ed25519"];
      enable = true;
    };

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      autocd = true;
      shellAliases = {
        e = "emacsclient -c -a '' $argv";
        sl = "exa";
        ls = "exa";
        l = "exa -l";
        la = "exa -la";
        buklo = "/home/ghishadow/github/buklo/target/release/buklo";
        ip = "ip --color=auto";
      };
      oh-my-zsh = {
        enable = true;
        plugins = ["git" "thefuck" "docker" "docker-compose" "direnv" "history-substring-search"];
      };
      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.5.0";
            sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
          };
        }
      ];
      initExtra = ''
        eval "$(starship init zsh --print-full-init)"
      '';
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
    git = {
      enable = true;
      userName = "Suraj Ghimire";
      userEmail = "suraj@ghishadow.com";
      aliases = {gl = "pull";};
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
        difftastic.enable = true;
        merge.conflictstyle = "diff3";
        diff.colorMoved = "default";
      };
    };
    helix = {
      enable = true;
    };
    bat.enable = true;
    #gpg.enable = true;
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    jq.enable = true;
    command-not-found.enable = true;
    dircolors.enable = true;
    htop.enable = true;
    info.enable = true;
    exa.enable = true;
    direnv = {
      enableZshIntegration = true;
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };
  };
}
