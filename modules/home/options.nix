{lib, ...}: {
  options.flake.homeModules = lib.mkOption {
    type = lib.types.attrsOf lib.types.raw;
    default = {};
  };
}
