{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.niri = {pkgs, ...}: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
    };
    services.greetd = {
      enable = true;
      settings.default_session.command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
    };
  };

  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        spawn-at-startup = [{command = ["noctalia-shell"];}];

        input.keyboard.xkb.layout = "de";
        layout.gaps = 8;

        binds = {
          "Mod+Return".action.spawn = ["${lib.getExe pkgs.foot}"];
          "Mod+Q".close-window = null;
          "Mod+D".action.spawn = ["noctalia-shell" "ipc" "call" "launcher" "toggle"];
          "Mod+Shift+E".action.spawn = ["noctalia-shell" "ipc" "call" "sessionMenu" "toggle"];
          "Mod+Alt+L".action.spawn = ["noctalia-shell" "ipc" "call" "lockScreen" "lock"];

          "XF86AudioRaiseVolume".action.spawn = ["noctalia-shell" "ipc" "call" "volume" "increase"];
          "XF86AudioLowerVolume".action.spawn = ["noctalia-shell" "ipc" "call" "volume" "decrease"];
          "XF86AudioMute".action.spawn = ["noctalia-shell" "ipc" "call" "volume" "muteOutput"];
          "XF86MonBrightnessUp".action.spawn = ["noctalia-shell" "ipc" "call" "brightness" "increase"];
          "XF86MonBrightnessDown".action.spawn = ["noctalia-shell" "ipc" "call" "brightness" "decrease"];
        };
      };
    };
  };
}
