{ ... }: {
  flake.nixosModules.preservation = { inputs, config, lib, ... }: {
    imports = [ inputs.preservation.nixosModules.preservation ];

    options.my.nixos.impermanence = {
      enable = lib.mkEnableOption "tmpfs root with preservation";
    };

    config = lib.mkIf config.my.nixos.impermanence.enable {
      preservation = {
        enable = true;
        preserveAt."/persist" = {
          files = [
            { file = "/etc/machine-id"; inInitrd = true; how = "symlink"; }
            "/etc/ssh/ssh_host_ed25519_key"
            "/etc/ssh/ssh_host_ed25519_key.pub"
          ];
          directories = [
            "/var/log"
            "/var/lib/nixos"
            "/var/lib/systemd/coredump"
            "/var/lib/steam"
          ];
          users.enderman = {
            directories = [
              ".config"
              ".local/share"
              ".local/state"
              "Downloads"
              "Projects"
              "Vault"
              ".gradle"
            ];
            files = [
              ".ssh/id_ed25519"
              ".ssh/id_ed25519.pub"
            ];
          };
        };
      };
    };
  };
}
