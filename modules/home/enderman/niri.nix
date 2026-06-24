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
      {command = ["noctalia-shell"];}
    ];

    # Keyboard Layout
    input.keyboard.xkb.layout = "de";
    layout.gaps = 8;

    # Keybinds
    binds = {
      # Terminal
      "Mod+Return".action.spawn = ["${lib.getExe pkgs.foot}"];

      # Launcher
      "Mod+D".action.spawn = ["noctalia-shell" "ipc" "call" "launcher" "toggle"];

      # Session Menu
      "Mod+Shift+E".action.spawn = ["noctalia-shell" "ipc" "call" "sessionMenu" "toggle"];

      # Lock Screen
      "Mod+Alt+L".action.spawn = ["noctalia-shell" "ipc" "call" "lockScreen" "lock"];

      # Volume/Brightness (Passthrough to noctalia)
      "XF86AudioRaiseVolume".action.spawn = ["noctalia-shell" "ipc" "call" "volume" "increase"];
      "XF86AudioLowerVolume".action.spawn = ["noctalia-shell" "ipc" "call" "volume" "decrease"];
      "XF86AudioMute".action.spawn = ["noctalia-shell" "ipc" "call" "volume" "muteOutput"];
      "XF86MonBrightnessUp".action.spawn = ["noctalia-shell" "ipc" "call" "brightness" "increase"];
      "XF86MonBrightnessDown".action.spawn = ["noctalia-shell" "ipc" "call" "brightness" "decrease"];
    };
  };
}
