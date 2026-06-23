{inputs, ...}: {
  flake.homeModules.enderman = {pkgs, ...}: {
    imports = [ inputs.noctalia.homeModules.default ];

    home = {
      username = "enderman";
      homeDirectory = "/home/enderman";
      stateVersion = "25.05";
    };
    programs.home-manager.enable = true;
  };
}
