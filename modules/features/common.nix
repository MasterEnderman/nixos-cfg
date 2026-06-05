{...}: {
  flake.nixosModules.common = {...}: {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.initrd.systemd.enable = true;

    time.timeZone = "Europe/Berlin";
    i18n.defaultLocale = "en_US.UTF-8";

    hardware.graphics.enable = true;
    hardware.bluetooth.enable = true;
    services.dbus.enable = true;
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
    services.pipewire.enable = true;
    services.pipewire.alsa.enable = true;
    services.pipewire.pulse.enable = true;
    security.polkit.enable = true;
    xdg.portal.enable = true;
    xdg.portal.wlr.enable = true;
    networking.networkmanager.enable = true;

    nix.settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      extra-substituters = ["https://noctalia.cachix.org"];
      extra-trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
    };

    system.stateVersion = "25.05";
  };
}
