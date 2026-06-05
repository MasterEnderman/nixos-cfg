{ inputs, ... }: {
  flake.homeModules.enderman = { pkgs, ... }: {
    home = {
      username      = "enderman";
      homeDirectory = "/home/enderman";
      stateVersion  = "25.05";
      packages      = with pkgs; [ foot fuzzel ];
    };

    programs.noctalia-shell = {
      enable   = true;
      settings = {
        colorSchemes.predefinedScheme = "Noctalia (default)";
        general.telemetryEnabled      = false;
      };
    };

    programs.home-manager.enable = true;
  };
}
