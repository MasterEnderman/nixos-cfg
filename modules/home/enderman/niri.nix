# modules/home/enderman/niri.nix
{
  pkgs,
  lib,
  ...
}: {
  # ═══════════════════════════════════════════════════════════
  # NIRI CONFIGURATION (Home Manager)
  # This is where keybinds and spawns live
  # ═══════════════════════════════════════════════════════════
  programs.niri.settings = {
    # Spawn noctalia-shell at startup
    spawn-at-startup = [
      {argv = ["noctalia"];}
    ];

    # Keyboard Layout
    input.keyboard.xkb.layout = "de";
    layout.gaps = 8;

    # Keybinds
    binds = {
      # --- navigation and window management ---
      "Mod+H".action.focus-column-left = {};
      "Mod+J".action.focus-window-down = {};
      "Mod+K".action.focus-window-up = {};
      "Mod+L".action.focus-column-right = {};

      "Mod+Left".action.focus-column-left = {};
      "Mod+Down".action.focus-window-down = {};
      "Mod+Up".action.focus-window-up = {};
      "Mod+Right".action.focus-column-right = {};

      "Mod+Tab".action.focus-window-down = {};
      "Mod+Q".action.close-window = {};
      "Mod+F".action.fullscreen-window = {};
      "Mod+M".action.maximize-column = {};

      "Mod+Comma".action.focus-workspace-up = {};
      "Mod+Period".action.focus-workspace-down = {};

      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;

      # Terminal
      "Mod+Return".action.spawn = ["${lib.getExe pkgs.foot}"];

      # Launcher
      "Mod+D".action.spawn = ["noctalia" "ipc" "call" "launcher" "toggle"];

      # Session Menu
      "Mod+Shift+E".action.spawn = ["noctalia" "ipc" "call" "sessionMenu" "toggle"];

      # Lock Screen
      "Mod+Alt+L".action.spawn = ["noctalia" "ipc" "call" "lockScreen" "lock"];

      # Volume/Brightness (Passthrough to noctalia)
      "XF86AudioRaiseVolume".action.spawn = ["noctalia" "ipc" "call" "volume" "increase"];
      "XF86AudioLowerVolume".action.spawn = ["noctalia" "ipc" "call" "volume" "decrease"];
      "XF86AudioMute".action.spawn = ["noctalia" "ipc" "call" "volume" "muteOutput"];
      "XF86MonBrightnessUp".action.spawn = ["noctalia" "ipc" "call" "brightness" "increase"];
      "XF86MonBrightnessDown".action.spawn = ["noctalia" "ipc" "call" "brightness" "decrease"];
    };
  };
}
