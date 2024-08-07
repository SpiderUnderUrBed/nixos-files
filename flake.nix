#{ lib, ... }:

{
  inputs = {
#    global-keybind.url = "github:justinrubek/global-keybind";
#    global-keybind.inputs.nixpkgs.follows = "nixpkgs";
#    global-keybind.inputs.home-manager.follows = "home-manager";
#    niv = {
 #    flake = false;
 #    url = "https://github.com/nmattia/niv/archive/e0ca65c81a2d7a4d82a189f1e23a48d59ad42070.tar.gz";
 #   };
#   niv.url = github:nmattia/niv;        
   #  flake-utils = {
  #  flake = true;
 #   url = "https://github.com/numtide/flake-utils/archive/997f7efcb746a9c140ce1f13c72263189225f482.tar.gz";
#  };
#  niv = {
#    flake = false;
#    url = "https://github.com/nmattia/niv/archive/e0ca65c81a2d7a4d82a189f1e23a48d59ad42070.tar.gz";
#  };
#   niv.url = "github:nmattia/niv";
   envycontrol.url = "github:bayasdev/envycontrol";   
   lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
   };
   auto-cpufreq = {
     url = "github:AdnanHodzic/auto-cpufreq";
     inputs.nixpkgs.follows = "nixpkgs";
   };
   sops-nix.url = "github:Mic92/sops-nix";        
   flake-compat.url = "github:edolstra/flake-compat";
   flake-compat.flake = false;    
 #  nur.url = github:nix-community/NUR;
    nix-revsocks.url = "github:SpiderUnderUrBed/nix-revsocks";
    wallpaper-changer.url = "github:SpiderUnderUrBed/wallpaper-changer";
#    wallpaper-changer.inputs.nixpkgs.follows = "nixpkgs";
#    wallpaper-changer.inputs.home-manager.follows = "home-manager";
    plasma-manager.url = "github:pjones/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";
    nix-software-center.url = "github:snowfallorg/nix-software-center";
    arion.url = "github:hercules-ci/arion";
    arion.inputs.nixpkgs.follows = "nixpkgs";    
#    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak"; 
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ 
    self, 
    nixpkgs, 
    auto-cpufreq,
    envycontrol,
    arion, 
    home-manager, 
    sops-nix,
    nix-flatpak, 
    plasma-manager, 
    nix-software-center,
    flake-compat,
    wallpaper-changer,
    nix-revsocks, 
    lanzaboote
   #global-keybind,
#    nur
#    niv
  }: let
    #lib = pkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    lib = pkgs.lib;
     needsSystem =
    output:
    builtins.elem output [
      "defaultPackage"
      "devShell"
      "devShells"
      "formatter"
      "legacyPackages"
      "packages"
    ];
#      constructInputs' = system: inputs:
#    lib.pipe inputs [
#      (lib.filterAttrs (_: lib.isType "flake"))
#      (lib.mapAttrs (_: lib.mapAttrs (name: value: if needsSystem name then value.${system} else value)))
#    ];

#  evalModules = names: inputs:
#    let
#      importWithInputs' = map (x: import x (constructInputs' system inputs));
#    in
#    lib.genAttrs names (
#      name:
#      lib.evalModules {
#        modules = importWithInputs' (./vfio.nix);
#      }
#    );
  
#  mkHosts = system: names:
#    evalModules names {};   
      #inherit (unstable) lib
#    constructInputs' =
#  
    #system: inputs:
#      lib.pipe inputs [
#        (lib.filterAttrs (_: lib.isType "flake"))
#        (lib.mapAttrs (_: lib.mapAttrs (name: value: if needsSystem name then value.${system} else value)))
#      ];
#    mkHosts = system: names:
#  let
#    evalModules = names: inputs:
#      let
#        importWithInputs' = map (x: import x (constructInputs' system inputs));
#      in
#      lib.genAttrs names (
#        name:
#        lib.evalModules {
#          modules = importWithInputs' (./vfio.nix);
#        }
#      );
#  in
#  evalModules names {};

#    icon-theme = stdenv.mkDerivation rec {
#  pname = "uos-fulldistro-icons";
#  version = "1.0";#

#  src = fetchFromGitHub {
#    owner = "zayronxio";
#    repo = "uos-fulldistro-icons";
#    rev = "master";  # or specify a commit hash, tag, or branch
#    sha256 = "0lnghszggbicgigga2l1ksx66xcipc29y6vq4walgkx6c7jkz65k";  # fill in the hash
#  };
#
#  installPhase = ''
#    mkdir -p $out/share/icons
#    cp -r $src $out/share/icons/uos-fulldistro-icons
#  '';#

#  meta = with lib; {
 #   description = "Uos Full Distro Icon Theme";
 #   homepage = "https://github.com/example/uos-fulldistro-icons";
 #   license = licenses.mit;
 #   maintainers = with maintainers; [shardseven];
 # };
#}#;

 #    otherOutputs = (import ./dirtyFlake.nix).outputs { system = system; };   
 #   startup = pkgs.writeShellApplication {
#       name = "startup";
#       runtimeInputs = [ pkgs.arion ];
#       text = "arion up";
#    };
  #  wallpaper-changer = import ./modules/wallpaper-changer/flake.nix;
  in {
#    hosts = mkHosts system [];
    nixosConfigurations.daspidercave = nixpkgs.lib.nixosSystem {
      inherit system;
#       mkHosts "x86_64-linux" [
#    "gerg-desktop"
#    "game-desktop"
#    "media-laptop"
#    "iso"
#  ];
#       (import ./niv.nix);
#       inherit (otherOutputs) args;
#      inherit (import ./dirtyFlake.nix).outputs args;
     #  nur.nixosModules.nur
  #   services.wallpaper-changer = {
 #     enable = true;
#    };
#      wallpaper-changer = "./modules/wallpaper-changer/flake.nix";
      modules = [
#        (import nixpkgs {}).runCommand "my-example" {} ''
#        echo test
#        ''     
        #startup
#       ./niv.nix 
#        (import ./niv.nix) 
#       ./arion
#       ./icon-theme.nix
        {
         environment.systemPackages = with pkgs; [
                envycontrol.packages.${system}.default
         ];
        }
        lanzaboote.nixosModules.lanzaboote
        auto-cpufreq.nixosModules.default
        ./vfio.nix
      ./configuration.nix  
#       ./lanzaboote.nix 
     ({ pkgs, lib, ... }: {
#
            environment.systemPackages = [
              # For debugging and troubleshooting Secure Boot.
              pkgs.sbctl
            ];

            # Lanzaboote currently replaces the systemd-boot module.
            # This setting is usually set to true in configuration.nix
            # generated at installation time. So we force it to false
            # for now.
            boot.loader.systemd-boot.enable = lib.mkForce false;

            boot.lanzaboote = {
              enable = true;
              pkiBundle = "/etc/secureboot";
            };
      })
#       ./modules/wallpaper-changer.nix 
#       nix-flatpak.nixosModules.nix-flatpak
#        ./flatpak.nix
#           nur.nixosModules.nur
#         inputs.sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
        # plasma-manager.homeManagerModules.plasma-manager
  
      {
          home-manager = {
           sharedModules = [ 
        #       startup
#               ./modules/wallpaper-changer.nix 
#                ./modules/wallpaper-changer
#               ./modules/wallpaper-changer/flake.nix.homeManagerModules.wallpaper-changer
#                (import ./modules/wallpaper-changer/flake.nix).homeManagerModules.wallpaper-changer
#       wallpaper-changer.homeManagerModules.wallpaper-changer
#               homeModules.global-keybind
#               global-keybind.homeModules.global-keybind
#               (import ./theme-manager.nix).homeManagerModules.mythemes
                 inputs.sops-nix.homeManagerModules.sops
                nix-revsocks.homeManagerModules.nix-revsocks
                wallpaper-changer.homeManagerModules.wallpaper-changer
                ./flatpak.nix nix-flatpak.homeManagerModules.nix-flatpak 
                ./home.nix 
                #./plasma.nix
                plasma-manager.homeManagerModules.plasma-manager 
          ];
               useGlobalPkgs = true;
               useUserPackages = true;
               users.spiderunderurbed = {
#               wallpaper = "./wallpapers";
#                  devShells.${system}.default =
   #     let pkgs = import nixpkgs { inherit system; }; in
   #     pkgs.mkShell {
  #        buildInputs = [
  #          home-manager.packages.${system}.home-manager
 #         ];
#        };
#    };
#        imports = [
#        ./niv.nix
#         ./modules/wallpaper-changer.nix
#       ];    
#       wallpaper = "./wallpapers";
             home = {
                stateVersion = "23.11";
                packages = [
#                  (homeModules.walpaper {
#                        wallpaper-changer.folder = "/etc/nixos/wallpapers";
#                  }
#                 );
                ];
#                programs.plasma = {
 #                 enable = true;
 #                 workspace = {
 #                   clickItemTo = "select";
 #                   wallpaper = "/home/spiderunderurbed/test.jpg";
 #                 };
 #               };
              };
            };
          };
          programs.gnupg.agent.pinentryPackage = pkgs.lib.mkForce pkgs.pinentry-qt;
        }
      ];
    };
  };
}
