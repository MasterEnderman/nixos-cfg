{ self, ... }: {
  flake.nixosModules.hardware-hp-probook = { ... }: {
    imports = [
      ./hardware-configuration.nix
      ./disko.nix
    ];
  };
}
