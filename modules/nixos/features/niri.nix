# modules/nixos/features/niri.nix
{
  inputs,
  pkgs,
  lib,
  ...
}: {
  # ═══════════════════════════════════════════════════════════
  # IMPORT NIRI OVERLAY
  # Gets access to 'niri-stable' and 'niri-unstable'
  # ═══════════════════════════════════════════════════════════
  nixpkgs.overlays = [inputs.niri.overlays.niri];

  # ═══════════════════════════════════════════════════════════
  # OPTIONS: Enable Niri and choose variant
  # ═══════════════════════════════════════════════════════════
  options.my.nixos.niri = {
    enable = lib.mkEnableOption "niri wayland compositor";
    variant = lib.mkOption {
      type = lib.types.enum ["stable" "unstable"];
      default = "stable";
      description = "Which Niri variant to use (stable or bleeding edge)";
    };
  };

  config = lib.mkIf config.my.nixos.niri.enable {
    # ═══════════════════════════════════════════════════════════
    # ENABLE NIRI COMPOSITOR
    # ═══════════════════════════════════════════════════════════
    programs.niri = {
      package =
        if config.my.nixos.niri.variant == "stable"
        then pkgs.niri-stable
        else pkgs.niri-unstable;

      # ═══════════════════════════════════════════════════════════
      # NIRI CONFIGURATION
      # This generates ~/.config/niri/config.kdl
      # ═══════════════════════════════════════════════════════════
      settings = {
        # Spawn noctalia-shell immediately when Niri starts
        spawn-at-startup = [
          {command = ["noctalia-shell"];}
        ];

        # Input Settings (Keyboard Layout)
        input.keyboard.xkb.layout = "de";

        # Visual Gaps
        layout.gaps = 8;

        # Keybindings
        binds = {
          # Terminal
          "Mod+Return".action.spawn = ["${lib.getExe pkgs.foot}"];

          # Launcher
          "Mod+D".action.spawn = ["noctalia-shell" "ipc" "call" "launcher" "toggle"];

          # Session Menu
          "Mod+Shift+E".action.spawn = ["noctalia-shell" "ipc" "call" "sessionMenu" "toggle"];

          # Lock Screen
          "Mod+Alt+L".action.spawn = ["noctalia-shell" "ipc" "call" "lockScreen" "lock"];

          # Volume Controls (Pass through to noctalia)
          "XF86AudioRaiseVolume".action.spawn = ["noctalia-shell" "ipc" "call" "volume" "increase"];
          "XF86AudioLowerVolume".action.spawn = ["noctalia-shell" "ipc" "call" "volume" "decrease"];
          "XF86AudioMute".action.spawn = ["noctalia-shell" "ipc" "call" "volume" "muteOutput"];

          # Brightness Controls
          "XF86MonBrightnessUp".action.spawn = ["noctalia-shell" "ipc" "call" "brightness" "increase"];
          "XF86MonBrightnessDown".action.spawn = ["noctalia-shell" "ipc" "call" "brightness" "decrease"];
        };
      };
    };

    # ═══════════════════════════════════════════════════════════
    # LOGIN MANAGER (Greetd + TUI Greet with AUTOLOGIN)
    # Boots directly into Niri Session as 'enderman' after LUKS decryption
    # ═══════════════════════════════════════════════════════════
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          # --autologin enderman skips the login prompt
          command = "${pkgs.tuigreet}/bin/tuigreet --autologin enderman --cmd niri-session";
        };
      };
    };
  };
}
