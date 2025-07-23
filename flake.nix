{
  description = "My flake";

  inputs = {
#    nix-gaming.url = "github:fufexan/nix-gaming";
    home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
    };
    hm-inputs.url = "/home/spiderunderurbed/home-manager";
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stable.url = "github:NixOS/nixpkgs/nixos-24.11";
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
    
    nix-software-center.url = "github:snowfallorg/nix-software-center";
    arion = {
      url = "github:hercules-ci/arion";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #nixos-cachyos-kernel.url = "github:drakon64/nixos-cachyos-kernel";
    #chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      #rev = "2ab29fd77896a69a77bb98fd792fb6102f44b449";
      #narHash = "sha256-aYDO6La5fuG5xzVYBFfoheWukwggcyh3LlfI0p+RnHw=";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";

 };

  outputs = { 
    self,
    nixpkgs, 
    auto-cpufreq, 
    envycontrol, 
    arion, 

    nix-flatpak, 
#    nix-gaming,

    chaotic,
    nix-software-center, 
    flake-compat, 
    home-manager,
    hyprland,   
    lanzaboote, 
    hm-inputs,
    ... 
  } @ inputs :
  let
#    home-setup = builtins.getFlake "/home/spiderunderurbed/home-manager"; 
#    extraSpecialArgs = hm-inputs.outputs.extraSpecialArgs;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    lib = nixpkgs.lib;
    gitCredentialManager = import ./spiderunderurbed/gcm.nix {
#        inherit pkgs;
        pkgs = pkgs;
        lib = pkgs.lib;
        stdenv = pkgs.stdenv;
        fetchFromGitHub = pkgs.fetchFromGitHub;
        dpkg = pkgs.dpkg;
        dotnet-sdk = pkgs.dotnet-sdk;
        buildDotnetModule = pkgs.buildDotnetModule;
        dotnetCorePackages = pkgs.dotnetCorePackages;
        xorg = pkgs.xorg;
       # libICE = pkgs.libICE;
       # libSM = pkgs.libSM;
        fontconfig = pkgs.fontconfig;
        libsecret = pkgs.libsecret;
        git = pkgs.git;
        git-credential-manager = pkgs.git-credential-manager;
        mkShell = pkgs.mkShell;
    };
      hydenixConfig = import ./spiderunderurbed/hydenix/config.nix;
      configLocation = "./";
     # netsecrets = builtins.getFlake "/home/spiderunderurbed/projects/net-secrets";
      #hm-lib = home-manager.lib;
      hm-modules = [
#        hm-inputs.inputs.sublimation.homeManagerModules.sublimation
#        hm-inputs.inputs.nixcord.homeManagerModules.nixcord
      ];
      extraSpecialArgs = {
          inherit 
		#netsecrets 
		hydenixConfig 
		gitCredentialManager 
		hm-modules 
		configLocation 
		home-manager; 
		inputs = hm-inputs;
      };
  in
  {
    formatter.${system} = pkgs.nixpkgs-fmt;
    nixosConfigurations.daspidercave = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = { 
	inherit 
	inputs; 
#	netsecrets; 
	#nix-gaming;
      };
# // extraSpecialArgs;
      modules = [
        lanzaboote.nixosModules.lanzaboote
        auto-cpufreq.nixosModules.default
	chaotic.nixosModules.default
	#nixos-cachyos-kernel.nixosModules.default
	#home-setup.nixosConfigurations.spiderunderurbed
#        home-setup.homeConfigurations.spiderunderurbed
        ./vfio.nix
        ./configuration.nix
        ./boot.nix

        ./registry.nix
        ./flatpak.nix

        nix-flatpak.nixosModules.nix-flatpak
        #home-manager.nixosModules.home-manager
#	netsecrets.nixosModules.default
        {
          #home-manager.useGlobalPkgs = true;
          #home-manager.useUserPackages = true;
#          home-manager.sharedModules = [
#		  hm-inputs.inputs.walker.homeManagerModules.default
 #                 hm-inputs.inputs.nixcord.homeManagerModules.nixcord
#		  hm-inputs.inputs.sublimation.homeManagerModules.sublimation
#		  #hm-inputs.inputs.walker
##        hm-inputs.inputs.nixcord.homeManagerModules.nixcord
# 
#         ];
	 # home-manager.extraSpecialArgs = extraSpecialArgs;
	 # home-manager.users.spiderunderurbed = { pkgs, ... }: {		
	#	#inherit specialArgs;
	#	#inherit extraSpecialArgs; 
	#	imports = [
	#	  	./spiderunderurbed/home.nix
	#		#(import ./spiderunderurbed/home.nix {})
	#	];
	#  };
        }

        {
#	  imports = [ home-setup.homeConfigurations ];
	  imports = [ 
	#	spider-config
	  ];
          environment.systemPackages = with pkgs; [
            envycontrol.packages.${system}.default
          ];

        }
      ];
    };
  };
}

