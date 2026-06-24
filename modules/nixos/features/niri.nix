# modules/nixos/features/niri.nix
{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  # ═══════════════════════════════════════════════════════════
  # OPTIONS: Enable Niri
  # ═══════════════════════════════════════════════════════════
  options.my.nixos.niri = {
    enable = lib.mkEnableOption "niri wayland compositor";
    variant = lib.mkOption {
      type = lib.types.enum ["stable" "unstable"];
      default = "stable";
    };
  };

  config = lib.mkIf config.my.nixos.niri.enable {
    # 1. Overlay & Binary Cache (Automatically enabled by the module usually, but explicit is safe)
    nixpkgs.overlays = [inputs.niri.overlays.niri];

    # Enable the NixOS module which auto-enables the Cachix cache
    imports = [inputs.niri.nixosModules.niri];

    # 2. Select Package
    programs.niri = {
      enable = true;
      package =
        if config.my.nixos.niri.variant == "stable"
        then pkgs.niri-stable
        else pkgs.niri-unstable;
    };

    # 3. Login Manager
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --autologin enderman --cmd niri-session";
        };
      };
    };
  };
}
