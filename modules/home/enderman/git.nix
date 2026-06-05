{...}: {
  flake.homeModules.enderman = {...}: {
    programs.git = {
      enable = true;
      settings.user.name = "MasterEnderman";
      settings.user.email = "xxmr.endermanxx@gmail.com";
    };
  };
}
