{
  description = "NixOS Configuration - Modular, Scalable & Minimal";

  inputs = {
    # ═══════════════════════════════════════════════════════════
    # CORE INPUTS
    # ═══════════════════════════════════════════════════════════
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager (Integrated as a NixOS module)
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ═══════════════════════════════════════════════════════════
    # FEATURES & TOOLS
    # ═══════════════════════════════════════════════════════════
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    preservation = {
      url = "github:nix-community/preservation";
    };

    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wrapper-modules = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    # ═══════════════════════════════════════════════════════════
    # HELPER: mkHost
    # Creates a complete NixOS configuration from just a hostname.
    # Automatically includes base features, HM setup, and host-specific modules.
    # Usage: my-machine = mkHost "my-machine";
    # ═══════════════════════════════════════════════════════════
    mkHost = hostname:
      nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs;
        };

        modules = [
          # 1. Host-Specific Module (Hardware, Disko, Unique Settings)
          ./modules/nixos/hosts/${hostname}

          # 2. Base System Defaults (User Account, Filesystem Flags, Feature Toggles)
          ./modules/nixos/features/base.nix

          # 3. Global Home Manager Setup (Shared across ALL machines)
          inputs.home-manager.nixosModules.home-manager
          ({
            lib,
            config,
            pkgs,
            inputs,
            ...
          }: {
            _module.args = {inherit inputs;};
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.enderman = {
              pkgs,
              lib,
              ...
            }: {
              imports = [./modules/home/enderman];

              home.username = "enderman";
              home.homeDirectory = "/home/enderman";
              home.stateVersion = "25.05";
              programs.home-manager.enable = true;
            };
          })
        ];
      };
  in {
    # ═══════════════════════════════════════════════════════════
    # NIXOS CONFIGURATIONS
    # Add new machines by simply adding a line here!
    # ═══════════════════════════════════════════════════════════
    nixosConfigurations = {
      hp-probook = mkHost "hp-probook";

      # Example: Add more machines easily
      # gaming-pc = mkHost "gaming-pc";
      # server-01 = mkHost "server-01";
    };
  };
}
