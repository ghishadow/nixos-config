{home-manager, ...}: {
  home-manager.users.ghishadow = {
    programs.mpv = {
      enable = true;
      bindings = {
        "Alt+j" = "add sub-scale -0.1";
        "Alt+k" = "add sub-scale +0.1";
      };
    };
  };
}
