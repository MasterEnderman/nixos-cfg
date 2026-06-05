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
        type = lib.types.enum ["cachyos" "cachyos-bore" "cachyos-lto"];
        default = "cachyos";
      };
    };

    config = lib.mkIf config.my.nixos.kernel.enable {
      nixpkgs.overlays = [inputs.nix-cachyos-kernel.overlays.default];
      boot.kernelPackages = pkgs.${"linuxPackages_${config.my.nixos.kernel.variant}"};
    };
  };
}
