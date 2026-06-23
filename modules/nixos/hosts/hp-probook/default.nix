# modules/nixos/hosts/hp-probook/default.nix
{...}: [
  ./hardware-configuration.nix
  ./disko.nix

  # Shared Features
  ../../features/common.nix
  ../../features/noctalia.nix
  ../../features/preservation.nix

  # Host Specifics
  {
    networking.hostName = "hp-probook";
  }
]
