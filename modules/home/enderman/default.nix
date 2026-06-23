# modules/home/enderman/default.nix
{lib, ...}: let
  # ═══════════════════════════════════════════════════════════
  # AUTO-DISCOVER ALL .NIX FILES IN THIS DIRECTORY
  # Excludes 'default.nix' itself to avoid recursion
  # ═══════════════════════════════════════════════════════════
  files = builtins.filter (
    name:
      name != "default.nix" && lib.hasSuffix ".nix" name
  ) (builtins.attrNames (builtins.readDir ./.));

  # Convert file names to relative paths
  imports = map (f: ./${f}) files;
in {
  # Import all sibling modules (git.nix, noctalia.nix, terminal.nix, etc.)
  imports = imports;

  # ═══════════════════════════════════════════════════════════
  # BASE HOME MANAGER SETTINGS
  # These are mandatory for any HM configuration
  # ═══════════════════════════════════════════════════════════
  home.username = "enderman";
  home.homeDirectory = "/home/enderman";

  # Must match the system stateVersion defined in common.nix
  home.stateVersion = "25.05";

  # Enable Home Manager's own management features
  programs.home-manager.enable = true;
}
