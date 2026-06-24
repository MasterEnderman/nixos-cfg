# modules/home/enderman/noctalia.nix
{
  pkgs,
  lib,
  ...
}: {
  programs.noctalia = {
    enable = true;
    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };
    };
  };
}
