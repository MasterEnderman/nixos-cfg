# modules/nixos/features/noctalia.nix
{pkgs, ...}: {
  # ═══════════════════════════════════════════════════════════
  # NOCTALIA CACHIX CACHE
  # Allows fast binary installation of noctalia-shell packages
  # ═══════════════════════════════════════════════════════════
  nix.settings = {
    extra-substituters = ["https://noctalia.cachix.org"];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
}
