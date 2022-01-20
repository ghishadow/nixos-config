{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;

  home.packages = [ pkgs.ctags ];
  programs.bat.enable = true;
  programs = {

    vscode = {
      enable = true;
      # package = pkgs.vscodium;    # You can skip this if you want to use the unfree version
      extensions = with pkgs.vscode-extensions; [
        # Some example extensions...
        dracula-theme.theme-dracula
        vscodevim.vim
        yzhang.markdown-all-in-one
      ];
    }

  }
}

