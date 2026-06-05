{...}: {
  flake.homeModules.enderman = {...}: {
    programs.git = {
      enable = true;
      userName = "MasterEnderman";
      userEmail = "xxmr.endermanxx@gmail.com";
    };
  };
}
