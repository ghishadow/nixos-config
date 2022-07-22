{
  config,
  pkgs,
  lib,
  inputs,
  overlays,
  ...
}: {
  # Pass these arguments to all imports
  # _module.args = {
  #   inherit pkgs overlays;
  # };
  imports = [
    ./bat
    ./foot
    ./zellij
    #./firefox
  ];
  systemd.user.sessionVariables = config.home.sessionVariables;
  gtk = {
    enable = true;
    font = {
      name = "Inter";
    };
    theme = {
      name = "Catppuccin-dark";
    };
    iconTheme = {
      name = "Papirus-Dark";
      #package = pkgs.papirus-icon-theme;
    };
  };
  # Enable discovery of fonts from installed packages
  fonts.fontconfig.enable = lib.mkForce true;
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    mime.enable = true;
    mimeApps.enable = true;
  };
  home.enableNixpkgsReleaseCheck = true;

  manual = {
    html.enable = true;
    manpages.enable = true;
    json.enable = true;
  };
  home.stateVersion = "22.11";
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    MOZ_WEBRENDER = 1;
    MOZ_DBUS_REMOTE = 1;
    CARGO_HOME = "\${XDG_DATA_HOME}/cargo";
    GNUPGHOME = "\${XDG_DATA_HOME}/gnupg";
    GTK2_RC_FILES = "\${XDG_CONFIG_HOME}/gtk-2.0/gtkrc";
    NODE_REPL_HISTORY = "\${XDG_DATA_HOME}/node_repl_history";
    NPM_CONFIG_USERCONFIG = "\${XDG_CONFIG_HOME}/npm/npmrc";
    # ZSH="\${XDG_DATA_HOME}/oh-my-zsh";
    PYTHONSTARTUP = "\${XDG_CONFIG_HOME}/python/pythonrc";
    RUSTUP_HOME = "\${XDG_DATA_HOME}/rustup";
    HISTFILE = "\${XDG_STATE_HOME}/zsh/history";
    ZDOTDIR = "\{$XDG_CONFIG_HOME}/zsh";
    XDG_CURRENT_DESKTOP = "sway";
    SDL_VIDEODRIVER = "wayland";
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "nvim";
    PAGER = "less -FirSwX";
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    WINIT_UNIX_BACKEND = "wayland";
    #MOZ_DISABLE_CONTENT_SANDBOX = 1;
  };

  home.packages = with pkgs; [
    # ui font
    inter
    gsettings-desktop-schemas
    wdisplays
    kleopatra
    fontforge
    pipes
    gnome.zenity
    gnome.nautilus
    python3
    sumneko-lua-language-server
    pinentry-curses
    btop
    cosign
    chezmoi
    wallutils
    graphviz
    papirus-folders
    papirus-icon-theme
    sunpaper
    catppuccin-gtk
    qutebrowser
    flyctl
    mesa-demos
    neovide
    perf-tools
    plotinus
    zlib
    patchelf
    miniserve
    nix-index
    sd
    wl-color-picker
    wl-clipboard
    fnm
    bun
    piper
    wlr-protocols
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk
    harec
    vulkan-tools
    hwinfo
    age
    zotero
    stylua
    tealdeer
    black
    ranger
    nodePackages.prettier
    autotiling
    git-ignore
    magic-wormhole
    cachix
    bind
    helvum
    jless
    glow
    asciinema
    # secret stuff
    gnome.gnome-themes-extra
    gtk-engine-murrine
    delta
    gtk_engines
    libtool
    # cmake
    # meson
    # ninja
    libvterm
    gnome.gnome-tweaks
    xdg-utils
    zathura
    libnotify
    lsof
    tokei
    glib
    gtkmm4
    fish
    wezterm
    fnott
    libsecret
    gsettings-desktop-schemas
    ffmpeg
    yt-dlp
    cmus
    cliphist
    lazygit
    sway-contrib.inactive-windows-transparency
    sway-contrib.grimshot
    grim
    # libstdcxx5
    sublime4
    sccache
    desktop-file-utils
    openssl
    editorconfig-core-c
    diskonaut
    fuzzel
    dua
    rclone
    nushell
    ctags
    sqlite
    fd
    ripgrep
    font-awesome
    gnumake
    unzip
    cached-nix-shell
    usbutils
    gnupg
    libu2f-host
    opensc
    pcsctools
    mosh
    #clang_multi
    clang_14
    clang-analyzer
    clang-tools
    clangStdenv
    llvmPackages_14.stdenv
    file
    enchant
    gnome3.adwaita-icon-theme
    gnome3.gnome-settings-daemon
    swaylock
    shellcheck
    bitwarden-cli
    # emacsPgtkNativeComp
    wget
    xorg.xprop
    xorg.xwininfo
    thefuck
    pciutils
    difftastic
    nix-tree
    git-crypt
    nixpkgs-review
    vscode-extensions.vadimcn.vscode-lldb
    rnix-lsp
    wlogout
    playerctl
  ];

  services = {
    playerctld.enable = true;
    swayidle.enable = true;
    mpd.enable = true;
    mpdris2 = {
      enable = true;
      notifications = true;
    };
    udiskie = {
      enable = true;
      automount = true;
      notify = true;
    };
    gpg-agent = {
      enable = true;
      enableZshIntegration = true;
      pinentryFlavor = "qt";
    };
  };
  # wayland.windowManager.sway = {
  #   enable = true;
  # };
  programs = {
    #home-manager = {
    #   enable = true;
    #};

    ssh = {
      enable = true;
      compression = true;
    };

    aria2 = {
      enable = true;
    };
    just = {
      enable = true;
      enableZshIntegration = true;
    };

    bottom = {
      enable = true;
    };

    waybar = {
      enable = true;
    };
    tiny = {
      enable = true;
      settings = {
        servers = [
          {
            addr = "irc.libera.chat";
            port = 6697;
            tls = true;
            realname = "Shadow";
            nicks = ["ghishadow"];
          }
        ];
        defaults = {
          nicks = ["ghishadow"];
          realname = "Shadow";
          join = ["#hare" "#sway"];
          tls = true;
        };
      };
    };
    gh = {
      enable = true;
      enableGitCredentialHelper = true;
      settings = {
        git_protocol = "https";
        prompt = "enabled";
        pager = "delta";
        aliases = {
          co = "pr checkout";
          pv = "pr view";
        };
      };
    };

    firefox = {
      enable = true;
      package = pkgs.firefox-wayland.override {
        forceWayland = true;
        extraPolicies = {
          ExtensionSettings = {};
        };
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        privacy-badger
      ];
    };

    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      withNodeJs = true;
      withPython3 = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    mcfly = {
      enable = true;
      enableZshIntegration = true;
      enableFuzzySearch = true;
      keyScheme = "emacs";
    };
    keychain = {
      enableZshIntegration = true;
      keys = ["id_ed25519"];
      enable = true;
    };

    zsh = {
      enable = false;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      enableVteIntegration = true;
      autocd = true;
      shellAliases = {
        wget = "wget --hsts-file=\${XDG_DATA_HOME}/wget-hsts";
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
        plugins = ["git" "thefuck" "docker" "docker-compose" "history-substring-search"];
      };
      initExtra = ''
        eval "$(starship init zsh --print-full-init)"
      '';
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
      };
    };
    topgrade = {
      enable = true;
      settings = {
        assume_yes = true;
        disable = [
          "flutter"
          "nix"
        ];
        set_title = false;
        cleanup = true;
        commands = {
          "Run garbage collection on Nix store" = "nix-collect-garbage";
        };
      };
    };
    git = {
      enable = true;
      ignores = ["*~" "*.swp" "target"];
      userName = "Suraj Ghimire";
      userEmail = "suraj@ghishadow.com";
      lfs = {
        enable = true;
      };
      signing = {
        signByDefault = true;
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG8jIo/7ypSugYtrtCEbtPkxe4Rtt/YELALAoRTKtK28";
      };
      extraConfig = {
        diff.algorithm = "histogram";
        #gpg.format = "ssh";
        #gpg.ssh.program = "${pkgs.openssh}/bin/ssh-keygen";
        core.pager = "delta";
        color.ui = true;
        github.user = "ghishadow";
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
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    pylint.enable = true;
    jq.enable = true;
    command-not-found.enable = true;
    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };
    man.enable = true;
    #mercurial = {
    # enable = true;
    # };
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
