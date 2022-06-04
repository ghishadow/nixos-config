{...}: {
  programs.foot = {
    enable = true;
    server = {
      enable = true;
    };
    settings = {
      main = {
        shell = "zsh";
        term = "xterm-256color";
        font = "Martian Mono:size=11";
        dpi-aware = true;
      };
      #url = {
      # launch = xdg-open ${url};
      # };
      colors = {
        alpha = 0.70;
        foreground = "d9e0ee";
        background = "1e1e2e";
        regular0 = "6e6c7e"; # black
        regular1 = "f28fad"; # red
        regular2 = "abe9b3"; # green
        regular3 = "fae3b0"; # yellow
        regular4 = "96cdfb"; # blue
        regular5 = "f5c2e7"; # magenta
        regular6 = "89dceb"; # cyan
        regular7 = "d9e0ee"; # white
        bright0 = "988ba2"; # bright black
        bright1 = "f28fad"; # bright red
        bright2 = "abe9b3"; # bright green
        bright3 = "fae3b0"; # bright yellow
        bright4 = "96cdfb"; # bright blue
        bright5 = "f5c2e7"; # bright magenta
        bright6 = "89dceb"; # bright cyan
        bright7 = "d9e0ee"; # bright white
      };
    };
  };
}
