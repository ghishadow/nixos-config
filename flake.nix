{
  description = "Shadow System Config";

  inputs = {
    # Core dependencies.
    nixpkgs.url = "nixpkgs/nixos-unstable"; # primary nixpkgs
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable"; # for packages on the edge
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    #lapce-overlay.url = "github:ghishadow/lapce-overlay";
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    #nixpkgs-wayland = {url = "github:nix-community/nixpkgs-wayland";};
    # only needed if you use as a package set:
    #nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs";
    #nixpkgs-wayland.inputs.master.follows = "master";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # Extras
    nixos-hardware.url = "github:nixos/nixos-hardware";

    vscode-server = {
      url = "github:msteen/nixos-vscode-server";
      flake = false;
    };
    emacs-overlay.url = "github:ghishadow/emacs-overlay";
    # Other packages
    zig.url = "github:arqv/zig-overlay";
    #moonlight.url = "github:mozilla/nixpkgs-mozilla";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    flake-utils,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
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
      inputs.emacs-overlay.overlay
      inputs.neovim-nightly-overlay.overlay
      (final: prev: {
        # Zig doesn't export an overlay so we do it here
        zig-master = inputs.zig.packages.${prev.system}.master.latest;
      })
      #inputs.lapce-overlay.overlay
      #inputs.moonlight.overlay
    ];
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      targus = lib.nixosSystem {
        inherit system;

        modules = [
          ({
            config,
            pkgs,
            ...
          }: {
            nixpkgs.overlays = overlays;
            environment.systemPackages = with pkgs; [
            ];
          })
          ./system/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
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

    templates = {
      full = {
        path = ./.;
        description = "A grossly incandescent nixos config";
      };
      minimal = {
        path = ./templates/minimal;
        description = "A grossly incandescent and minimal nixos config";
      };
    };
    defaultTemplate = self.templates.minimal;

    devShell."${system}" = import ./shell.nix {inherit pkgs;};
  };
}
