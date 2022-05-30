{
  description = "Shadow System Config";

  inputs = {
    # Core dependencies.
    nixpkgs.url = "nixpkgs/nixos-unstable"; # primary nixpkgs
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable"; # for packages on the edge
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:ghishadow/home-manager/main";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    #lapce-overlay.url = "github:ghishadow/lapce-overlay";
    agenix.url = "github:ryantm/agenix";
    nur.url = "github:nix-community/NUR";
    # agenix.inputs.nixpkgs.follows = "nixpkgs";
    # only needed if you use as a package set:
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    # Extras
    nixos-hardware.url = "github:nixos/nixos-hardware";

    vscode-server = {
      url = "github:msteen/nixos-vscode-server";
      flake = false;
    };
    emacs.url = "github:ghishadow/emacs-overlay";
    # Other packages
    #moonlight.url = "github:mozilla/nixpkgs-mozilla";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    flake-utils,
    agenix,
    nur,
    neovim-nightly,
    emacs,
    ...
  }: let
    # hosts = import ./hosts;
    system = "x86_64-linux";
    vars = {
      user = "ghishadow";
      theme = "dark";
    };
    pkgs = import nixpkgs {
      inherit system;
      config = {
        nix = {
          # add binary caches
          binaryCachePublicKeys = [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          ];
          binaryCaches = [
            "https://cache.nixos.org"
          ];
        };
        allowUnfree = true;
        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 7d --max-freed $((64 * 1024**3))";
        };
        optimise = {
          automatic = true;
          dates = ["weekly"];
        };
      };
    };
    overlays = [
      emacs.overlay
      neovim-nightly.overlay
      nur.overlay
      #inputs.lapce-overlay.overlay
      #inputs.moonlight.overlay
    ];
    lib = nixpkgs.lib;
  in {
    # nixosConfigurations = builtins.mapAttrs
    # (hostname: config:
    #   (config(inputs // rec {
    #     common-cfg = {
    #       inherit system;
    #       config.allowUnfree = true;
    #     };
    #     system = "x86_64-linux";
    #     inherit vars;
    #     overlays = overlays;

    #     })).nixosConfiguration)
    #   hosts;
    nixosConfigurations = {
      targus = lib.nixosSystem {
        inherit system;

        modules = [
          agenix.nixosModule
          ({
            config,
            pkgs,
            ...
          }: {
            nixpkgs.overlays = overlays;
          })
          ./system/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = inputs // {inherit inputs;};
            home-manager.users.ghishadow =
              import ./users/ghishadow/home.nix;
          }
        ];
      };
    };
    # used in non-NixOS
    # homeConfigurations = {
    #     ghishadow = home-manager.lib.homeManagerConfiguration {
    #       inherit system pkgs;
    #       username = "ghishadow";
    #       homeDirectory = "/home/ghishadow/";
    #       configuration = { pkgs, ... }: {
    #         programs.home-manager.enable = true;
    #         nixpkgs.overlays = overlays;
    #         imports = [ ./users/ghishadow/home.nix ];
    #       };
    #     };
    #   };

    # templates = {
    #   full = {
    #     path = ./.;
    #     description = "A grossly incandescent nixos config";
    #   };
    #   minimal = {
    #     path = ./templates/minimal;
    #     description = "A grossly incandescent and minimal nixos config";
    #   };
    # };
    # templates.default = self.templates.minimal;

    devShells."${system}".default = import ./shell.nix {inherit pkgs;};
  };
}
