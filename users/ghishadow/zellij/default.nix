{...}: {
  programs.zellij = {
    enable = true;
    settings = {
      theme = "tokyo-night";
      pane-frames = false;
      default-shell = "nu";
      tokyo-night = {
        fg = [169 177 214]; #A9B1D6
        bg = [26 27 38]; #1A1B26
        black = [56 62 90]; #383E5A
        red = [249 51 87]; #F9334D
        green = [158 206 106]; #9ECE6A
        yellow = [224 175 104]; #E0AF68
        blue = [122 162 247]; #7AA2F7
        magenta = [187 154 247]; #BB9AF7
        cyan = [42 195 222]; #2AC3DE
        white = [192 202 245]; #C0CAF5
        orange = [255 158 100]; #FF9E64
      };
    };
  };
}
