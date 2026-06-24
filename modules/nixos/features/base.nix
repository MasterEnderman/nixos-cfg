# modules/nixos/features/base.nix
{lib, ...}: {
  imports = [
    ./common.nix
    ./kernel.nix
    ./niri.nix
    ./noctalia.nix
    ./preservation.nix
    ./zen.nix
  ];
  # ═══════════════════════════════════════════════════════════
  # DEFAULT USER ACCOUNT (Shared across all hosts)
  # Change password via: echo 'newpass' | sudo nixos-rebuild switch --set-option users.users.enderman.hashedPassword '...'
  # Note: This is a placeholder. Please set a real password after first boot!
  # To generate a hash: mkpasswd -m sha-512
  # ═══════════════════════════════════════════════════════════
  users.users.enderman = {
    isNormalUser = true;
    description = "Enderman's User Account";

    # ⚠️ DANGER: Temporary Password!
    # CHANGE THIS IMMEDIATELY AFTER FIRST BOOT
    initialPassword = "password";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
    ];
  };

  # ═══════════════════════════════════════════════════════════
  # FILESYSTEM FLAGS FOR IMPERMANENCE
  # Required because /nix and /persist are bind-mounted from separate volumes
  # ═══════════════════════════════════════════════════════════
  fileSystems."/nix".neededForBoot = true;
  fileSystems."/persist".neededForBoot = true;

  # ═══════════════════════════════════════════════════════════
  # DEFAULT FEATURE ENABLEMENT
  # Enables these features on ALL hosts by default.
  # Override in specific host files if needed (e.g., disable Niri on server).
  # ═══════════════════════════════════════════════════════════
  my.nixos.kernel.enable = true;
  my.nixos.kernel.variant = "linuxPackages-cachyos-bore";

  my.nixos.niri.enable = true;
  my.nixos.niri.variant = "stable";

  my.nixos.impermanence.enable = true;
}
