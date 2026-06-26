# modules/home/enderman/terminal.nix
{
  pkgs,
  lib,
  ...
}: {
  # ═══════════════════════════════════════════════════════════
  # TERMINAL PACKAGES
  # Fast system info tools
  # ═══════════════════════════════════════════════════════════
  home.packages = with pkgs; [
    fastfetch # Modern, colorful system info
    pfetch-rs # Rust rewrite of pfetch (fast)
    btop      # TUI Taskmanager
    alejandra # Nix formatter
  ];

  # ═══════════════════════════════════════════════════════════
  # DEFAULT TERMINAL SETTING
  # Sets $TERMINAL variable for other apps
  # ═══════════════════════════════════════════════════════════
  home.sessionVariables = {
    TERMINAL = "foot";
  };

  # ═══════════════════════════════════════════════════════════
  # FOOT TERMINAL EMULATOR CONFIGURATION
  # Light and fast Wayland terminal
  # ═══════════════════════════════════════════════════════════
  programs.foot = {
    enable = true;

    settings = {
      main = {
        font = "monospace:size=11";
      };
    };
  };

  # ═══════════════════════════════════════════════════════════
  # BASH SHELL CUSTOMIZATION
  # ═══════════════════════════════════════════════════════════
  programs.bash = {
    enable = true;

    bashrcExtra = ''
      pfetch
    '';
  };
}
