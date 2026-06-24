# modules/nixos/hosts/hp-probook/default.nix
{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  # ═══════════════════════════════════════════════════════════
  # IMPORTS LIST
  # This returns a list of modules to be loaded for this host
  # ═══════════════════════════════════════════════════════════
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
  ];

  # ═══════════════════════════════════════════════════════════
  # HOST-SPECIFIC CONFIGURATION
  # Overrides and unique settings
  # ═══════════════════════════════════════════════════════════
  networking.hostName = "hp-probook";
}
