# modules/nixos/features/niri.nix
{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    inputs.niri.nixosModules.niri
  ];

  # ═══════════════════════════════════════════════════════════
  # OPTIONS: Enable Niri and choose variant
  # ═════════════──────────────────────────────────────────────
  options.my.nixos.niri = {
    enable = lib.mkEnableOption "niri wayland compositor";
    variant = lib.mkOption {
      type = lib.types.enum ["stable" "unstable"];
      default = "stable";
      description = "Which Niri variant to use (stable or bleeding edge)";
    };
  };

  # ═══════════════════════════════════════════════════════════
  # CONFIGURATION
  # ═══════════════════════════════════════════════════════════
  config = lib.mkIf config.my.nixos.niri.enable {
    # 1. Overlay (Required to get niri-stable/unstable packages)
    nixpkgs.overlays = [inputs.niri.overlays.niri];

    # 2. Enable Compositor & Select Package
    programs.niri = {
      enable = true;
      package =
        if config.my.nixos.niri.variant == "stable"
        then pkgs.niri-stable
        else pkgs.niri-unstable;
    };

    # 3. Login Manager (Autologin)
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
