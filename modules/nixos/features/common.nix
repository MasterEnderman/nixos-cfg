# modules/nixos/features/common.nix
{
  config,
  lib,
  pkgs,
  ...
}: {
  # ═══════════════════════════════════════════════════════════
  # BOOT & HARDWARE
  # ═══════════════════════════════════════════════════════════
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    initrd.systemd.enable = true;
  };

  # ═══════════════════════════════════════════════════════════
  # LOCALIZATION
  # ═══════════════════════════════════════════════════════════
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  # ═══════════════════════════════════════════════════════════
  # GRAPHICS & AUDIO
  # ═══════════════════════════════════════════════════════════
  hardware = {
    graphics.enable = true;
    bluetooth.enable = true;
  };

  # ═══════════════════════════════════════════════════════════
  # SYSTEM SERVICES
  # ═══════════════════════════════════════════════════════════
  services = {
    dbus.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
    };
  };

  networking.networkmanager.enable = true;
  security.polkit.enable = true;

  # ═══════════════════════════════════════════════════════════
  # GLOBAL NIX SETTINGS
  # ═══════════════════════════════════════════════════════════
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
}
