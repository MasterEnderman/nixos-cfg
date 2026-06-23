# modules/home/enderman/noctalia.nix
{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  # ═════════════──────────────────────────────────────────────
  # NOCTALIA CONFIGURATION
  # Theme and display settings
  # ═══════════════════════════════════════════════════════════
  programs.noctalia = {
    enable = true;

    # Settings structure matches ~/.config/noctalia/settings.json
    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };
    };
  };
}
