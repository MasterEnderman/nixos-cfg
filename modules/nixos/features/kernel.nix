# modules/nixos/features/kernel.nix
{
  inputs,
  pkgs,
  lib,
  ...
}: {
  # Define options for flexibility across hosts
  options.my.nixos.kernel = {
    enable = lib.mkEnableOption "cachyos performance kernel";
    variant = lib.mkOption {
      type = lib.types.enum [
        "linuxPackages-cachyos"
        "linuxPackages-cachyos-bore"
        "linuxPackages-cachyos-latest"
      ];
      default = "linuxPackages-cachyos-latest";
      description = "Which CachyOS kernel variant to use";
    };
  };

  config = lib.mkIf config.my.nixos.kernel.enable {
    # 1. Add the Overlay to get the packages
    nixpkgs.overlays = [inputs.nix-cachyos-kernel.overlays.pinned];

    # 2. Select the specific kernel variant
    boot.kernelPackages = pkgs.cachyosKernels.${config.my.nixos.kernel.variant};

    # 3. Add the specific Lantian Substituter
    nix.settings = {
      substituters = ["https://attic.xuyh0120.win/lantian"];
      trusted-public-keys = ["lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="];
    };
  };
}
