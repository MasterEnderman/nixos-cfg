{inputs, ...}: {
  flake.nixosModules.kernel = {
    config,
    lib,
    pkgs,
    ...
  }: {
    options.my.nixos.kernel = {
      enable = lib.mkEnableOption "cachyos performance kernel";
      variant = lib.mkOption {
        type = lib.types.enum ["linuxPackages-cachyos" "linuxPackages-cachyos-bore" "linuxPackages-cachyos-latest"];
        default = "linuxPackages-cachyos-latest";
      };
    };

    config = lib.mkIf config.my.nixos.kernel.enable {
      nixpkgs.overlays = [inputs.nix-cachyos-kernel.overlays.pinned];
      boot.kernelPackages = pkgs.cachyosKernels.${config.my.nixos.kernel.variant};

      nix.settings = {
        substituters = ["https://attic.xuyh0120.win/lantian"];
        trusted-public-keys = ["lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="];
      };
    };
  };
}
