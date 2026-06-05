{...}: {
  flake.homeModules.enderman = {...}: {
    programs.noctalia-shell = {
      enable = true;
      settings = {
        colorSchemes.predefinedScheme = "Noctalia (default)";
        general.telemetryEnabled = false;
      };
    };
  };
}
