# modules/home/enderman/zen.nix
{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  # Helper for extensions
  mkExtension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };

  ublock = mkExtension "ublock-origin" "uBlock0@raymondhill.net";

  # Preferences map
  prefs = {
    "extensions.autoDisableScopes" = 0;
    "extensions.pocket.enabled" = false;
    "browser.startup.page" = 3;
    "browser.newtabpage.activity-stream.showSponsored" = false;
    "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    "privacy.trackingprotection.enabled" = true;
    "privacy.trackingprotection.socialtracking.enabled" = true;
  };

  extensions = [ublock];

  # Search engines configuration
  searchEngines = {
    Default = "ddg";
    Add = [
      {
        Name = "Nix Packages";
        URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
        IconURL = "https://nixos.org/_assets/nix-logo-2.svg";
        Alias = "@np";
      }
      {
        Name = "NixOS Options";
        URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
        IconURL = "https://nixos.org/_assets/nix-logo-2.svg";
        Alias = "@no";
      }
      {
        Name = "NixOS Wiki";
        URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
        IconURL = "https://wiki.nixos.org/favicon.ico";
        Alias = "@nw";
      }
      {
        Name = "Noogle";
        URLTemplate = "https://noogle.dev/q?term={searchTerms}";
        IconURL = "https://noogle.dev/favicon.ico";
        Alias = "@ng";
      }
      {
        Name = "GitHub";
        URLTemplate = "https://github.com/search?q={searchTerms}";
        IconURL = "https://github.com/fluidicon.png";
        Alias = "@gh";
      }
      {
        Name = "Wikipedia";
        URLTemplate = "https://en.wikipedia.org/wiki/Special:Search?search={searchTerms}";
        IconURL = "https://www.wikipedia.org/static/favicon/wikipedia.ico";
        Alias = "@wiki";
      }
    ];
  };
in {
  home.packages = [
    (
      pkgs.wrapFirefox
      (inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped)
      {
        extraPrefs = lib.concatLines (
          lib.mapAttrsToList
          (name: value: ''lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});'')
          prefs
        );

        extraPolicies = {
          DisableTelemetry = true;
          ExtensionSettings = builtins.listToAttrs extensions;
          SearchEngines = searchEngines;
        };
      }
    )
  ];
}
