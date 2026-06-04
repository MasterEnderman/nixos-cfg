{ self, inputs, ... }: {
  flake.nixosConfigurations.hp-probook = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.hardware-hp-probook
      self.nixosModules.common
      self.nixosModules.niri
      self.nixosModules.preservation
      self.nixosModules.kernel
      inputs.disko.nixosModules.disko
      inputs.home-manager.nixosModules.home-manager
      {
        networking.hostName = "hp-probook";

        boot.initrd.luks.devices."cryptroot".device =
          "/dev/disk/by-partlabel/disk-main-luks";

        my.nixos.impermanence.enable = true;

        my.nixos.kernel = {
          enable  = true;
          variant = "cachyos-bore";
        };

        home-manager = {
          useGlobalPkgs   = true;
          useUserPackages = true;
          sharedModules   = [ inputs.noctalia.homeModules.default ];
          users.enderman  = { imports = [ self.homeModules.enderman ]; };
        };
      }
    ];
  };
}
