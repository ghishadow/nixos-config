{pkgs, ...}: {
  firefox = {
    enable = true;
    package = pkgs.firefox-wayland.override {
      forceWayland = true;
      extraPolicies = {
        ExtensionSettings = {};
      };
    };
    #   extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    # privacy-badger
    # ];
  };
}
