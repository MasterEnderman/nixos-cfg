{
  inputs = {
    nixpkgs.url     = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    home-manager       = { url = "github:nix-community/home-manager";  inputs.nixpkgs.follows = "nixpkgs"; };
    disko              = { url = "github:nix-community/disko";         inputs.nixpkgs.follows = "nixpkgs"; };
    preservation.url   = "github:nix-community/preservation";
    niri               = { url = "github:sodiboo/niri-flake";          inputs.nixpkgs.follows = "nixpkgs"; };
    noctalia           = { url = "github:noctalia-dev/noctalia-shell"; inputs.nixpkgs.follows = "nixpkgs"; };
    wrapper-modules.url    = "github:BirdeeHub/nix-wrapper-modules";
    nix-cachyos-kernel = { url = "github:xddxdd/nix-cachyos-kernel";  inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; }
    (inputs.import-tree ./modules);
}
