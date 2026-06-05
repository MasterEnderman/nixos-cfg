{inputs, ...}: {
  flake.homeModules.enderman = {pkgs, ...}: {
    home = {
      username = "enderman";
      homeDirectory = "/home/enderman";
      stateVersion = "25.05";
    };
    programs.home-manager.enable = true;
  };
}
