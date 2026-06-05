{self, ...}: {
  flake.nixosModules.hardware-hp-probook = {...}: {
    imports = [
      ./_hardware-configuration.nix
      ./_disko.nix
    ];
  };
}
