# modules/nixos/hosts/hp-probook/disko.nix
{pkgs, ...}: {
  # ═══════════════════════════════════════════════════════════
  # DISK LAYOUT VIA DISKO
  # Creates: EFI partition → LUKS → Btrfs subvolumes (/@, /persist, /swap)
  # Root (/) is tmpfs for impermanence
  # ═══════════════════════════════════════════════════════════
  disko.devices = {
    # Main Physical Disk
    disk.main = {
      type = "disk";
      device = "/dev/nvme0n1"; # ⚠️ ADJUST THIS IF YOUR DISK IS DIFFERENT

      content = {
        type = "gpt";

        partitions = {
          # EFI System Partition
          ESP = {
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["umask=0077"];
            };
          };

          # LUKS Encrypted Btrfs Container
          luks = {
            size = "100%"; # Use remaining disk space
            content = {
              type = "luks";
              name = "cryptroot";
              settings.allowDiscards = true; # SSD optimization

              content = {
                type = "btrfs";
                extraArgs = ["-f"]; # Force creation on existing data

                subvolumes = {
                  # Nix Store (Rebuilt every install)
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["compress=zstd" "noatime"];
                  };

                  # Persistent User Data (Survives Reboots)
                  "@persist" = {
                    mountpoint = "/persist";
                    mountOptions = ["compress=zstd" "noatime"];
                  };

                  # Swap File (Inside Btrfs)
                  "@swap" = {
                    mountpoint = "/.swapvol";
                    swap.swapfile.size = "16G";
                  };
                };
              };
            };
          };
        };
      };
    };

    # Impermanent Root Filesystem (Tmpfs)
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [
        "defaults"
        "size=2G" # Adjust based on RAM
        "mode=755"
      ];
    };
  };
}
