# modules/home/enderman/noctalia.nix
{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  programs.noctalia = {
    enable = true;
    settings = {
      theme = {
        mode = "dark";
        source = "wallpaper";
        wallpaper_scheme = "m3-content";
        builtin = "Catppuccin";
      };

      wallpaper = {
        enabled = true;
        default.path = "/persist/etc/nixos/modules/nixos/hosts/${osConfig.networking.hostName}/wallpaper.png";
      };
    };
  };
}
