{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.hp-probook = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.hardware-hp-probook
      self.nixosModules.common
      self.nixosModules.niri
      self.nixosModules.preservation
      self.nixosModules.kernel
      self.diskoConfigurations.hp-probook
      inputs.disko.nixosModules.disko
      inputs.home-manager.nixosModules.home-manager
      {
        networking.hostName = "hp-probook";

        fileSystems."/nix".neededForBoot = true;
        fileSystems."/persist".neededForBoot = true;

        my.nixos.impermanence.enable = true;

        my.nixos.kernel = {
          enable = true;
          variant = "linuxPackages-cachyos-bore";
        };

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.enderman = {imports = [self.homeModules.enderman];};
        };

        users.users.enderman = {
          isNormalUser = true;
          extraGroups = ["wheel" "networkmanager" "video" "audio"];
        };
      }
    ];
  };
}
