# modules/home/enderman/git.nix
{
  pkgs,
  lib,
  ...
}: {
  # ═══════════════════════════════════════════════════════════
  # GIT CONFIGURATION
  # Note: 'settings' was replaced by 'extraConfig' in recent HM versions
  # ═══════════════════════════════════════════════════════════
  programs.git = {
    enable = true;

    # Configuration via extraConfig (attribute set or list)
    extraConfig = {
      user.name = "MasterEnderman";
      user.email = "xxmr.endermanxx@gmail.com";

      init.defaultBranch = "master";
      pull.rebase = true;
    };
  };
}
