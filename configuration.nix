
{ config, pkgs, inputs, lib, ... }:

let 

  #hyprlandConfig = ((import ./hyprland.nix) { lib = lib; pkgs = pkgs; }) // { enable = false; };
  acermodule = config.boot.kernelPackages.callPackage ./acer-module.nix {};
  coreutils = pkgs.writeShellApplication {
     name = "coreutils";
     runtimeInputs = [
	pkgs.coreutils
     ];
     text = ''
	realpath /dev/dri/by-path/pci-0000:00:02.0-card 
     '';
  };

startup = pkgs.writeShellApplication {
  name = "startup";
  runtimeInputs = [];
  text = ''

  '';
};
kdePkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/20afb4559c29bf544eeffb90a2dfd1afd6541902";
});
pinnedKde = final: prev: {
    services.xserver.desktopManager.plasma6 = kdePkgs.services.xserver.desktopManager.plasma6;
};
arion = pkgs.writeShellApplication {
  name = "arion";
  runtimeInputs = [
    pkgs.screen
    pkgs.docker-compose
    pkgs.docker
    pkgs.nix
    (import (fetchTarball "https://github.com/nixos/nixpkgs/archive/23.11.tar.gz") {}).arion
  ];
  text = ''

    screen -S arion_session -d -m nix-shell -p arion --run "arion -p /etc/nixos/arion-pkgs.nix -f /etc/nixos/arion-compose.nix up"
  '';
};

    aagl = import (builtins.fetchTarball "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz");

  nix-software-center = import (pkgs.fetchFromGitHub {
    owner = "snowfallorg";
    repo = "nix-software-center";
    rev = "0.1.2";
    sha256 = "xiqF1mP8wFubdsAQ1BmfjzCgOD3YZf7EGWl9i69FTls=";
  }) {};
  concatMapStringsSep = { sep, f, list }:
    builtins.concatStringsSep sep (map (x: f x + "\n") list);
in 

{
nixpkgs.config.allowUnsupportedSystem = true;
nixpkgs.overlays = [
pinnedKde

];

aagl.enableNixpkgsReleaseBranchCheck = false;

systemd = {
user.services = {
"xwayland-ensure" = {
  description = "Backup xwaylandserver";
  wantedBy = ["graphical-session.target"];
  #enable = true;
  requisite = ["graphical-session.target"];
  after = ["graphical-session.target"];
  partOf = ["graphical-session.target"];
  bindsTo = ["graphical-session.target"];
  serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash -c 'if ! ${pkgs.procps}/bin/pgrep X > /dev/null; then ${pkgs.xwayland-satellite}/bin/xwayland-satellite :0; fi'";
      Restart = "always";
  };
};
"pasystray-ensure" = {
    description = "PulseAudio Tray Application (pasystray)";
    wantedBy = ["xwayland-ensure.service"];
#    enable = true;
    after = ["xwayland-ensure.service"];
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash -c 'if ! ${pkgs.procps}/bin/pgrep pasystray > /dev/null; then ${pkgs.pasystray}/bin/pasystray --display=:0; fi'";
      Restart = "always";
    };
};
};
services = {

};
};

security.sudo.enable = true;

security.pki.certificates = [ ''

-----BEGIN CERTIFICATE-----
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
hCncJu0OBrcLizP9UYJmH+7iVg==
-----END CERTIFICATE-----
'' ];
networking = { 

interfaces."enp46s0".wakeOnLan = {

enable = true;
};
nameservers = [
"8.8.8.8" 

"100.100.100.100"]; 

};

  security.polkit.enable = true;
  security.polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (action.id == "org.debian.pcsc-lite.access_pcsc" &&
          subject.isInGroup("wheel")) {
          return polkit.Result.YES;
        }
      });
  '';
services.tailscale.enable = true;

services = {

geoclue2 = {
enable = false;
};
gpsd = {
enable = false;
port = 3330;
};
rsyslogd = {
enable = true;
extraConfig = "auth,authpriv.*                 /var/log/auth.log";
};
mullvad-vpn = {
enable = false;
};

displayManager = {
   execCmd = lib.mkDefault "exec ${pkgs.sddm}/bin/sddm";
   sessionPackages = [
 	pkgs.hyprland
  ];

};

usbguard = {

};
beesd.filesystems = {

main = {
   spec = "LABEL=home";
   hashTableSizeMB = 2048;
   verbosity = "crit";
   extraOptions = [ "--loadavg-target" "5.0" ];
};
};
tlp = {
enable = false;

};
monero = {
enable = false;
limits.threads=2;
mining = {
enable= false;
address="47XA83EZZvdiBbtJH7oF5UYvzCGFEW94dHFRamPFoaDfjXHJDWHuHHQYP9qDTb2itr3ZijVrTsnn4Vf7gVUdgFEpDicDiZU";
};
};

  syncthing = {
        enable = true;
	user = "spiderunderurbed";
	configDir = "/home/spiderunderurbed/syncthing/etc";
	dataDir = "/home/spiderunderurbed/syncthing/data";
   };
   packagekit.enable = true; 

expressvpn.enable = true;	

};

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; 
  [
   # overskride
    hyprland
    copyq
    pasystray
    swayosd
    pavucontrol
    kitty
  ] ++
  [
    pyenv
    bc
    jq
    blueman
    fortune 
    pavucontrol
    xwayland
    xwayland-satellite
 ] ++
  [
	alsa-lib
	pkg-config
 	openssl
	ollama
	rustup
	sbctl
	efibootmgr
	anki
	cryfs
	sherlock
	shell-gpt
	feh

	yt-dlp
	gh
	avml
	volatility3
	wget
	bsd-finger
	pnpm

	brave
	google-chrome
	home-manager
	swift
	xclicker
	lutris-free
	android-studio
	legendary-gl
	wine
	nmap

	heroic
	gcc
	sl
	cmatrix
	weston
	expressvpn
	rustfmt

	protonmail-bridge
	guake
	cloudflared
	vitetris

	ettercap

	audacity
	bottles

	vlc
	virt-manager
	bleachbit

	screen
	stacer
	xmrig
	monero-gui
	duperemove

	tmux
	typescript
	bun
	go
	bluetuith
	mangohud
	hyfetch
	keychain
	(vscode-with-extensions.override {
	   vscodeExtensions = with vscode-extensions; [ 

	      svelte.svelte-vscode

	     (pkgs.vscode-utils.buildVscodeMarketplaceExtension { 
		    mktplcRef = {
     		      name = "python";
		      version = "1.19.1";

		      publisher = "ms-python";
		    };
		    vsix = /home/spiderunderurbed/ms-python-latest.zip;

	       })

	      ritwickdey.liveserver
	      sswg.swift-lang
	      vadimcn.vscode-lldb
	      bbenoist.nix

	      ms-vscode-remote.remote-containers
	      ms-vscode-remote.remote-ssh

	      rust-lang.rust-analyzer
	      ms-azuretools.vscode-docker

	      eamodio.gitlens
	  ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [

		{
		name = "remove-comments";
		publisher = "plibither8";
		version = "1.2.2";
		sha256 = "ca2ef0e0a937a3da822c849a98c587d280b464287f590883b4febb2ec186d7de";
		}
		{
		name = "vencord-companion";
		publisher = "Vendicated";

		version = "0.1.3";
		sha256 = "9854440646f703deb7a5a1ec3e115a60b7c87c8ea0d17f46bbd45502d5e100e4";
		}

		{

		 name = "codespaces";
		 publisher = "Github";
		 version = "1.16.17";
		 sha256 = "e9c47ef5f69b8cba144f2dc4038f6aaef4274c52b45c6b533008a3db897d546a";
		}
		{
        		name = "remote-ssh-edit";
        		publisher = "ms-vscode-remote";
        		version = "0.47.2";
        		sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
      		}
	        {
        	  	name = "Go";
        		publisher = "golang";
        	  	version = "0.42.0";
      		  	sha256 = "f47c9ee44ccbb181fc5f718de3ee27de3349d4f603ec155fccef332a882141d5";
     		}

	  ];
	})

	git-credential-manager
	python3
	logseq
	rage
	onlyoffice-bin

	vesktop

	thefuck
	zoxide
	chezmoi
	xorg.xhost

	latte-dock
	cargo
	rustc 
	nextcloud-client
	keepassxc

	prismlauncher
	minicom

	thunderbird
	yubikey-agent
	yubikey-touch-detector
	age-plugin-yubikey
	yubikey-personalization-gui
	yubikey-manager

	godot3

	emacs

	vscodium
	pcscliteWithPolkit.out
	pcsclite  
        gnupg

	yakuake 
	config.services.headscale.package  
	nginx 
	docker-compose
	distrobox 
        git 
	gparted 
	htop 
	libfido2 
	linux-pam 
	usbutils
	docker
	age
	hyprshot

	nix-software-center
	nodejs

	arion

  ];

virtualisation = {
docker.enable = true;
waydroid.enable = true;
};

virtualisation.oci-containers = {
  backend = "docker";
   containers = {

    coweire = {};

    };
};
virtualisation.oci-containers.containers.coweire.image = "cowrie/cowrie:latest";
virtualisation.oci-containers.containers.coweire.ports = ["22:2222"];

hardware.bluetooth.enable = true; 
hardware.bluetooth.powerOnBoot = true; 
hardware.enableAllFirmware = true;

  nixpkgs.config.nvidia.acceptLicense = true;
  services.xserver.videoDrivers = ["nvidia" "intel"];

  hardware.nvidia = {

    package = config.boot.kernelPackages.nvidiaPackages.latest;
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    dynamicBoost.enable = true;

    powerManagement = {
      enable = true;

    };

    prime = {
      intelBusId = "PCI:00:02:0"; 

      nvidiaBusId = "PCI:01:00:0";
      reverseSync.enable = false;
      sync.enable = false;

      offload = {
        enable = false;
        enableOffloadCmd = false;
      };
    };
  };

  specialisation = {

    GDM.configuration = {
   services = {
    displayManager = {
	execCmd = lib.mkForce "exec ${pkgs.gnome.gdm}/bin/gdm";
     };
     xserver = {
	displayManager = {

	gdm = {

		enable = true;
		wayland = true;

	};
     };
    };
   };
  };
  DVfio.configuration = {
	environment.extraInit = ''

		export KWIN_DRM_DEVICES=$(${coreutils}/bin/coreutils)
  	'';
  };
  Battery.configuration = {
    system.nixos.tags = [ "Battery" ];
    boot.extraModprobeConfig = ''
  blacklist nouveau
  options nouveau modeset=0
'';

services.udev.extraRules = ''s

  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"

  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"

  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"

  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
'';
boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
  };
};

services.flatpak.enable = true;
services.pcscd.enable = true;

networking.firewall = {
  enable = true;
  checkReversePath = "loose";
  trustedInterfaces = [ "tailscale0" "waydroid0" ];
  allowedTCPPorts = [ 3060 22 8384 22000 51820 67 53 ]; 
  allowedUDPPorts = [ 22000 21027 51820 67 53 config.services.tailscale.port]; 

};

security.pam.services = {
  sddm.enableKwallet = true;
  login.u2fAuth = true;
 };

services.openssh.ports = [3060];
services.udev.packages = [ pkgs.yubikey-personalization pkgs.libu2f-host ];

  boot.kernelPackages = 

	pkgs.linuxPackages_zen;

  boot.extraModulePackages = 

    [  
	acermodule  
	config.boot.kernelPackages.v4l2loopback.out
    ];

  boot.kernelModules = [

    "facer" "wmi" "sparse-keymap" "video" 

    "v4l2loopback"

    "snd-aloop"
  ];

  boot.extraModprobeConfig = ''

    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
  '';

services.openssh = {
  enable = true;

  settings.PasswordAuthentication = false;
  settings.KbdInteractiveAuthentication = false;

};

  environment.shellInit = ''
    export GPG_TTY="$(tty)"
  '';

  environment.etc = {
      "jdks/17".source = "${pkgs.openjdk17}/bin";
      "jdks/8".source = "${pkgs.openjdk8}/bin";
  };
  programs = {
  uwsm = {
    enable = true;
    waylandCompositors.hyprland = {
      binPath = "/run/current-system/sw/bin/Hyprland";
      comment = "Hyprland session managed by uwsm";
      prettyName = "Hyprland";
    };
  };
   thunar = {
     enable = true;
   };
  #hyprland = (hyprlandConfig);

  chromium = {
        enable = true;

        extensions = [
	   "enamippconapkdmgfgjchkhakpfinmaj" 
           "cjpalhdlnbpafiamejdnhcphjbkeiagm" 
           "nngceckbapebfimnlniiiahkandclblb" 
           "mnjggcdmjocbbbhaepdhchncahnbgone" 
           "eimadpbcbfnmbkopoojfekhnkhdbieeh" 
	   "gebbhagfogifgggkldgodflihgfeippi" 
	   "cimiefiiaegbelhefglklhhakcgmhkai" 
	   "ghbmnnjooekpmoecnnnilnnbdlolhkhi" 
	   "kaacflffkmlaiebklgemhmlfbhificko" 

	   "kbfnbcaeplbcioakkpcpgfkobkghlhen" 

       ];
    };
    firefox = {
	enable = true;
	package = pkgs.librewolf;

	preferences = {
	  "browser.tabs.groups.enabled" = true;
	};
	policies.ExtensionSettings = {
               "uBlock0@raymondhill.net" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                    installation_mode = "force_installed";
      	        };
		"{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
		    install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
		    installation_mode = "force_installed";
   	        };	
		"addon@darkreader.org" = {
		    install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
		    installation_mode = "force_installed";
		};
		"{c2c003ee-bd69-42a2-b0e9-6f34222cb046}" = {
		    install_url = "https://addons.mozilla.org/firefox/downloads/latest/auto-tab-discard/latest.xpi";
		    installation_mode = "force_installed";
		};
		"sponsorBlocker@ajay.app" = {
		    install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
		    installation_mode = "force_installed";
		};
		"plasma-browser-integration@kde.org" = {
		    install_url = "https://addons.mozilla.org/firefox/downloads/latest/plasma-integration/latest.xpi";
		    installation_mode = "force_installed";
		};
		"deArrow@ajay.app" = {
		    install_url = "https://addons.mozilla.org/firefox/downloads/latest/dearrow/latest.xpi";
		    installation_mode = "force_installed";
		};

		"87677a2c52b84ad3a151a4a72f5bd3c4@jetpack" = {
		    install_url = "https://addons.mozilla.org/firefox/downloads/latest/grammarly-1/latest.xpi";
		    installation_mode = "force_installed";
		};

    	  };
    };

    gamescope.enable = true;
    anime-game-launcher.enable = true;
    ssh = {
	extraConfig = ''
		PermitLocalCommand=yes
	'';

	askPassword = "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";
    };

    dconf= {
      enable = true;

    }; 

    git = {
      enable = true;
      package = pkgs.gitFull;
      config.credential.helper = "libsecret";
    };

    xwayland.enable = true;

    proxychains = {
	enable = false;

    };
    kdeconnect.enable = true;
    bash = {
	shellInit = "export NIXPKGS_ALLOW_INSECURE=1"; 
    };
    steam = {

     enable = true;
      remotePlay.openFirewall = true; 
      dedicatedServer.openFirewall = true; 
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
  security.pam = {

    u2f.enable = true;
  };

  virtualisation.virtualbox.host.enable = true;
   users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
  imports =
   [ 

	./hyprland/nixos-module.nix
	aagl.module

        ./hardware-configuration.nix

  ];

  boot.kernel.sysctl = { "net.ipv4.tcp_window_scaling" = true; "net.ipv4.conf.all.forwarding" = true; };
  boot.supportedFilesystems = [ "ntfs" ];

  boot.runSize = "100%";

  networking.hostName = "daspidercave"; 

  networking.networkmanager = {
	enable = true;
  	wifi = {
	 backend = "wpa_supplicant"; 
	 powersave = false;
  	};
  };

  time.timeZone = "Pacific/Auckland";

  i18n.defaultLocale = "en_NZ.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_NZ.UTF-8";
    LC_IDENTIFICATION = "en_NZ.UTF-8";
    LC_MEASUREMENT = "en_NZ.UTF-8";
    LC_MONETARY = "en_NZ.UTF-8";
    LC_NAME = "en_NZ.UTF-8";
    LC_NUMERIC = "en_NZ.UTF-8";
    LC_PAPER = "en_NZ.UTF-8";
    LC_TELEPHONE = "en_NZ.UTF-8";
    LC_TIME = "en_NZ.UTF-8";
  };

  services.xserver = {

    enable = true;
    displayManager = {
		hiddenUsers = [ "jellyfin" ]; 
		sddm = {

			wayland.enable = true;
			enable = true;
	    	};
	};

    desktopManager = {
     plasma6.enable = true; 
     gnome.enable = false;
    };
  };

  services.xserver = {
    layout = "nz";
    xkbVariant = "";
  };

  nix = {
    extraOptions = ''

    '';
  };

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

  };

  environment.extraInit = ''
    export TEST=test

  ''; 

  fonts.packages = with pkgs; [
  	noto-fonts
  	noto-fonts-cjk-sans
  	noto-fonts-emoji
  	liberation_ttf
  	fira-code
  	fira-code-symbols
  	mplus-outline-fonts.githubRelease
  	dina-font
  	proggyfonts
  ];

  users.users = {
   jellyfin = {
     isNormalUser = true;
     description = "jellyfin";
     extraGroups = [ "networkmanager" "wheel" ];	
   };
   guest = {
     isNormalUser = true;
     description = "guest";
     extraGroups = [ "networkmanager" ];   
   };
   spiderunderurbed = {
    isNormalUser = true;
    description = "SpiderUnderUrBed";
    #linger = true;
    openssh.authorizedKeys.keys = [];
    extraGroups = [ 
	"libvirtd"
	"networkmanager"
	"wheel" 
	"docker"

	];
    packages = with pkgs; [
      firefox
      kate

    ];
  };
};

   nixpkgs.config.allowUnfree = true;
   nixpkgs.config.permittedInsecurePackages = [
		"electron"
           	"electron-27.3.11"
		"electron-25.9.0"
		"electron-28.3.3"
   ];

  hardware.pulseaudio.support32Bit = true;

  boot.tmp.useTmpfs = true;
  system = {
	stateVersion = "24.11"; 
        activationScripts = { 
	stdio = lib.mkForce {
        text = ''	

	echo "Ran sucessfully"

	${arion}/bin/arion 
	${startup}/bin/startup	
        '';
	};
  };
};
}
