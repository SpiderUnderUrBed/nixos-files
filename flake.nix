{
  description = "My project using personal NUR repository";

  inputs = {
 #   my-home-manager.url = "/home/spiderunderurbed/home-manager/";
#    nixcord = {
#      url = "github:kaylorben/nixcord"
#    };
#<<<<<<< HEAD
#=======
    #sober = {
    #  url = "https://sober.vinegarhq.org/sober.flatpakref";
    #  flake = false;
    #};
#>>>>>>> cdcb124 (Initial commit)
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    envycontrol.url = "github:bayasdev/envycontrol";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
#    nix-revsocks.url = "github:SpiderUnderUrBed/nix-revsocks";
#    plasma-manager = {
#      url = "github:pjones/plasma-manager";
#      inputs.nixpkgs.follows = "nixpkgs";
#      inputs.home-manager.follows = "home-manager";
#    };
#    sublimation.url = "github:SpiderUnderUrBed/sublimation";
    nix-software-center.url = "github:snowfallorg/nix-software-center";
    arion = {
      url = "github:hercules-ci/arion";
      inputs.nixpkgs.follows = "nixpkgs";
    };
#    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-flatpak.url = "github:gmodena/nix-flatpak/fix-flatpakref-install";
   # nix-flatpak.url = "github:gmodena/nix-flatpak/nix-flatpakref-install?rev=e637f51f6523c8fad28af79ea6b1f64697fa9945";
 };

  outputs = { 
    self,
    nixpkgs, 
    auto-cpufreq, 
    envycontrol, 
    arion, 
    #home-manager, 
    nix-flatpak, 
   # plasma-manager, 
    nix-software-center, 
    flake-compat, 
    home-manager,
   # nix-revsocks, 
    lanzaboote, 
    ... 
  } @ inputs :
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    lib = nixpkgs.lib;
  in
  {
    nixosConfigurations.daspidercave = nixpkgs.lib.nixosSystem {
      inherit system;
#      nixpkgs.overlays = [ final: prev: {
#        extraSpecialArgs = {
#          inherit inputs;  # Pass inputs as extraSpecialArgs
#        };
#      }];
#       nixpkgs.overlays = [
#         (final: prev: {
#           extraSpecialArgs = {
#      	     inherit inputs;  # Pass inputs as extraSpecialArgs
#     	   };
#  	  })
#	];

 #     imports = [
#	(import ./flatpak.nix { inherit inputs })
#      ];
      modules = [
        lanzaboote.nixosModules.lanzaboote
        auto-cpufreq.nixosModules.default
        ./vfio.nix
        ./configuration.nix
	#./flatpak.nix
	(import ./flatpak.nix { inherit lib pkgs inputs; }) 
#		extraSpecialArgs = {
#			inherit inputs;
#		}
		#inherit inputs; 
#	})
#<<<<<<< HEAD
#        home-manager.nixosModules.home-manager
#        {
#          home-manager.useGlobalPkgs = true;
#          home-manager.useUserPackages = true;
#        }
#=======
	nix-flatpak.nixosModules.nix-flatpak
	home-manager.nixosModules.home-manager
	{
	  home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
	}
#>>>>>>> cdcb124 (Initial commit)
        {
          environment.systemPackages = with pkgs; [
            envycontrol.packages.${system}.default
          ];
          boot.loader.systemd-boot.enable = pkgs.lib.mkForce false;
          boot.lanzaboote = {
            enable = false;
            pkiBundle = "/etc/secureboot";
          };
        }
      ];
    };
  };
}
#<<<<<<< HEAD

#=======
#>>>>>>> cdcb124 (Initial commit)
