{...}: {
  flake.homeModules.enderman = {
    pkgs,
    lib,
    ...
  }: {
    home.packages = with pkgs; [fastfetch pfetch-rs];

    home.sessionVariables.TERMINAL = "foot";

    programs.foot = {
      enable = true;
      settings.main.font = "monospace:size=11";
    };

    programs.bash.bashrcExtra = ''
      pfetch
    '';
  };
}
