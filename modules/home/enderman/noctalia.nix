{...}: {
  flake.homeModules.enderman = {inputs, ...}: {
    home-manager.users.enderman = {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      programs.noctalia = {
        enable = true;

        settings = {
          # This may also be a string or path to a .toml file.
          theme = {
            mode = "dark";
            source = "builtin";
            builtin = "Catppuccin";
          };
        };
      };
    };
  };
}
