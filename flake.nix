{
  description = "Shadow System Config";

  inputs = {
    # Core dependencies.
    nixpkgs.url = "nixpkgs/nixos-unstable"; # primary nixpkgs
    nixpkgs-unstable.url =
      "nixpkgs/nixpkgs-unstable"; # for packages on the edge
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-wayland = { url = "github:nix-community/nixpkgs-wayland"; };
    # only needed if you use as a package set:
    nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-wayland.inputs.master.follows = "master";
    # Extras
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Other packages
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    zig.url = "github:arqv/zig-overlay";
  };

  outputs =
    inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, flake-utils, ... }:
    with builtins;
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      lib = nixpkgs.lib;
    in {

      # nixosConfigurations = {
      #   targus = lib.nixosSystem {
      #     inherit system;

      #     modules = [ ./system/configuration.nix ];
      #   };
      # };
      overlays = [
        inputs.neovim-nightly-overlay.overlay
        inputs.nixpkgs-wayland.overlay
      ];
      environment.systemPackages = with pkgs; [
        inputs.nixpkgs-wayland.packages.${system}.waybar
        inputs.nixpkgs-wayland.packages.${system}.grim
      ];
      homeConfigurations = {
        ghishadow = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          username = "ghishadow";
          homeDirectory = "/home/ghishadow/";
          configuration = { pkgs, ... }: {
            programs.home-manager.enable = true;
            nixpkgs.overlays = overlays;
            imports = [ ./users/ghishadow/home.nix ];
          };
        };
      };

    };
}
