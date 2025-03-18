{ lib, pkgs, inputs, options, specialArgs, modulesPath, config, ... }: 
let
#inherit config;
inherit (lib.strings) escapeNixIdentifier;
inherit (builtins) toFile parseFlakeRef;
inherit (inputs) self;
inherit (lib) mkEnableOption mkIf;
nixpkgs = inputs.nixpkgs;
#inherit (lib) mkFlake repoLockedTestResult flakeClosureRef;
in
{
    system.configurationRevision = mkIf (self ? rev) self.rev;

    # Indirect our NIX_PATH through /etc so that it updates without a
    # relog
    nix.nixPath = [ "/etc/nix/path" ];

    # Don't talk to the internet every time I use the registry
    # I don't use it anyway
    nix.settings.flake-registry = toFile "global-registry.json" ''{"flakes":[],"version":2}'';

    # the version of nixpkgs used to build the system
    nix.registry.nixpkgs.flake = nixpkgs;
    environment.etc."nix/path/nixpkgs".source = nixpkgs;

    # the version of home-manager used to build the system
    #nix.registry.home-manager.flake = home-manager;
    #environment.etc."nix/path/home-manager".source = home-manager;

    # the version of this flake used to build the system
    nix.registry.activeconfig.flake = self;
    environment.etc."nix/path/activeconfig".source = self;

    # the (runtime) current version of this flake
    nix.registry.config.to = { type = "path"; path = "/mnt/persist/spiderunderurbed/flake"; };
    environment.etc."nix/path/config".source = "/mnt/persist/spiderunderurbed/flake";

    nix.registry.nixpkgs-unstable.to = parseFlakeRef "github:NixOS/nixpkgs/nixos-unstable";
}
