{lib, ...}: {
  options.flake.homeModules = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.deferredModule;
    default = {};
  };

  config.flake.homeModules.enderman = {
    imports = [inputs.noctalia.homeModules.default];
  };
}
