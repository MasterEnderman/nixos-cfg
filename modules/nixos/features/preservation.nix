# modules/nixos/features/preservation.nix
{
  inputs,
  config,
  lib,
  pkgs,
  config,
  ...
}: {
  # ═══════════════════════════════════════════════════════════
  # IMPORT PRE-SERVATION MODULE
  # Sets up tmpfs root (/) and persistent storage (/persist)
  # ═══════════════════════════════════════════════════════════
  imports = [inputs.preservation.nixosModules.preservation];

  # ═══════════════════════════════════════════════════════════
  # OPTIONS: Enable Impermanent Root
  # ═══════════════════════════════════════════════════════════
  options.my.nixos.impermanence = {
    enable = lib.mkEnableOption "tmpfs root with persistent /persist storage";
  };

  config = lib.mkIf config.my.nixos.impermanence.enable {
    preservation = {
      enable = true;

      # All preserved data goes here
      preserveAt."/persist" = {
        # System files that must survive reboots
        files = [
          {
            file = "/etc/machine-id";
            inInitrd = true; # Required for early boot
            how = "symlink";
          }
          "/etc/ssh/ssh_host_ed25519_key"
          "/etc/ssh/ssh_host_ed25519_key.pub"
        ];

        directories = [
          "/var/log"
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
          "/var/lib/steam"
        ];

        # User-specific persistence
        users.enderman = {
          directories = [
            ".config"
            ".local/share"
            ".local/state"
            "Downloads"
            "Projects"
            "Vault"
            ".gradle"
          ];

          files = [
            ".ssh/id_ed25519"
            ".ssh/id_ed25519.pub"
          ];
        };
      };
    };
  };
}
