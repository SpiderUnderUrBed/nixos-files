{ config, pkgs, inputs, lib, ... }:

let 
  homeInputs = (builtins.getFlake ./spiderunderurbed/flake.nix).inputs; 
  
  #hyprlandConfig = ((import ./hyprland.nix) { lib = lib; pkgs = pkgs; inputs = homeInputs; }) // { enable = false; };
  patchDesktop = pkg: appName: from: to: lib.hiPrio (
    pkgs.runCommand "$patched-desktop-entry-for-${appName}" {} ''
      ${pkgs.coreutils}/bin/mkdir -p $out/share/applications
      ${pkgs.gnused}/bin/sed 's#${from}#${to}#g' < ${pkg}/share/applications/${appName}.desktop > $out/share/applications/${appName}.desktop
      '');
  GPUOffloadApp = pkg: desktopName: patchDesktop pkg desktopName "^Exec=" "Exec=nvidia-offload ";

  acermodule = config.boot.kernelPackages.callPackage ./acer-module.nix {};
  vfio = pkgs.writeShellApplication {
     name = "vfio";
     runtimeInputs = [
        pkgs.coreutils
     ];
     text = ''
        realpath /dev/dri/by-path/pci-0000:00:02.0-card 
     '';
  };

#unstablePkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") {};
baseconfig = { 
	allowUnfree = true; 
#	expressvpn.enable = true;
};
stable = import inputs.stable { config = baseconfig; };
#secondary = import inputs.secondary { config = baseconfig; };
#baseconfig = { allowUnfree = true; };

# Check if inputs.nixpkgs version is 24.11, and set 'secondary' accordingly
#unstable = if inputs.nixpkgs.version == "24.11" thene
  #import inputs.secondary { config = baseconfig; }
#else
  #pkgs;

#baseconfig = { allowUnfree = true; };

# Check if the nixpkgs URL corresponds to the stable version (24.11)
#stable = if (inputs.nixpkgs.url == "github:NixOS/nixpkgs/nixos-24.11") then
#  import inputs.secondary { config = baseconfig; }
#else
#  pkgs;

startup = pkgs.writeShellApplication {
  name = "startup";
  runtimeInputs = [];
  text = ''

  '';
};
#kdePkgs = import (builtins.fetchTarball {
#    url = "https://github.com/NixOS/nixpkgs/archive/20afb4559c29bf544eeffb90a2dfd1afd6541902";
#});
#pinnedKde = final: prev: {
#    services.xserver.desktopManager.plasma6 = kdePkgs.services.xserver.desktopManager.plasma6;
#};
hyprlandEnable = true;
secondaryEnable = true;
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
#pinnedKde

];

aagl.enableNixpkgsReleaseBranchCheck = false;

systemd.user.services = {
#"dunst" = {
#description = "Dunst notification daemon";
#after = [ "wayland-wm@Hyprland.service" ];
#partOf = [ "graphical-session.target" ];

#};
"xwayland-ensure" = {
  description = "Backup xwaylandserver";
  wantedBy = ["wayland-wm@Hyprland.service"];
  #plasma-plasmashell.service
  #wantedBy = ["wayland-wm@hyprland\x2duwsm.desktop.service"];
  #wantedBy = ["graphical-session.target"];
  enable = true;
  requisite = ["graphical-session.target"];
  after = ["graphical-session.target"];
 # after = ["wayland-wm@hyprland\x2duwsm.desktop.service"];
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
#"hyprpaper-ensure"
};
services = {

};
#};

security.sudo.enable = true;

security.pki.certificates = [ ''
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

expressvpn = { 
enable = true;
package = stable.expressvpn;
};
};

 # nix.settings.experimental-features = [ "nix-command" "flakes" ];
disabledModules = [ "services/networking/expressvpn.nix" ];

environment.systemPackages = 
  [ pkgs.expressvpn ]
  ++ (with pkgs; 
  (lib.optionals hyprlandEnable [
   # overskride
    hdrop
    hyprland 
    hyprpaper
    copyq
    pasystray
    swayosd
    pavucontrol
    kitty
  ]) ++
  (lib.optionals secondaryEnable [
    #pyenv
    bc
    jq
    blueman
    fortune 
    pavucontrol
    xwayland
    xwayland-satellite
 ]) ++
  [
#	gamemoderun
	localsend
        pciutils
        libnotify
        #parted
        #mplayer
        killall
#       lf
        unzip
        blesh
        pyenv
        appimage-run
        rmtrash
        waypipe
        tree
        php
        alsa-lib
        pkg-config
        openssl
        ollama
        rustup
        tldr
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
#       xclicker
        lutris-free
        android-studio
        legendary-gl
        wine
        nmap

#       heroic
        gcc
        sl
        cmatrix
        weston
        
        rustfmt

        protonmail-bridge
        guake
        cloudflared
        vitetris

        ettercap

        audacity
#       bottles

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
                name = "rustowl-vscode";
                publisher = "cordx56";
                version = "0.1.1";
                sha256 = "c295da5fc07b966ae79b078c71aa0e64776dcdcdf9b099f263188cf3170231d4";
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

#       nix-software-center
        nodejs

        arion

  ]);

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
  services.xserver.videoDrivers = ["nvidia"];

  #hardware.opengl.enable = true;
  #hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;


  hardware.nvidia = {
    #package = unstablePkgs
    package = config.boot.kernelPackages.nvidiaPackages.beta;
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

  environment.sessionVariables = {
#       "NIX_CONF_DIR" = "/etc/nixos/nix/";
  };
#ix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  nix = {
        settings = {
                auto-optimise-store = true;
                experimental-features = [ "nix-command" "flakes" ];
        };
        extraOptions = ''
          download-buffer-size = 67108864
        '';
  };
  specialisation = {

    GDM.configuration = {
   services = {
    displayManager = {
        execCmd = lib.mkForce "exec ${pkgs.gdm}/bin/gdm";
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
        environment.variables = {
          KWIN_DRM_DEVICES = lib.mkForce "";
        };
        environment.extraInit = ''
                export KWIN_DRM_DEVICES=$(${vfio}/bin/vfio)
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
  
  #boot.`kernelParams = [ "
  #boot.blacklistedKernelModules = [ "nouveau" ];
  boot.kernelPackages = 
#       pkgs.linuxPackages_latest;
        stable.linuxPackages_zen;

  boot.extraModulePackages = 

    [  
        acermodule  
        config.boot.kernelPackages.v4l2loopback.out
    ];
  boot.tmp = {
        cleanOnBoot = true; 
        useTmpfs = true;
        tmpfsSize = "100%";
  };
   boot.kernelModules = [

    "facer" "wmi" "sparse-keymap" "video" 

    "v4l2loopback"

    "snd-aloop"
  ];

  boot.extraModprobeConfig = ''
   options v4l2loopback exclusive_caps=1 video_nr=10 card_label="Virtual Camera"
  '';

services.openssh = {
  enable = true;

  settings.PasswordAuthentication = false;
  settings.KbdInteractiveAuthentication = false;

};

  environment.shellInit = ''
    export GPG_TTY="$(tty)"
  '';
  environment.variables = rec {
    KWIN_DRM_DEVICES="/dev/dri/card0:/dev/dri/card1";
  };
  environment.etc = {
       #"nixos/test" = {
	# source = pkgs.writeText "test.conf" ''
	#  test
	# '';
	# mode = "0440";
       #};
      "jdks/17".source = "${pkgs.openjdk17}/bin";
      "jdks/8".source = "${pkgs.openjdk8}/bin";
  };
  programs = {
  gamemode.enable = true;
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
  java = { enable = true; };
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
           "cbghhgpcnddeihccjmnadmkaejncjndb"
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
                "{aecec67f-0d10-4fa7-b7c7-609a2db280cf}" = {
                    install_url = "https://addons.mozilla.org/firefox/downloads/latest/violentmonkey/latest.xpi";
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
    #package = with pkgs; (GPUOffloadApp steam "steam");
     package = pkgs.steam;
     extraCompatPackages = with pkgs; [
       proton-ge-bin
     ];
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
	./expressvpn.nix
        ./hyprland/nixos-module.nix
        aagl.module
        ./hardware-configuration.nix

  ];

  boot.kernel.sysctl = {
         "kernel.unprivileged_userns_clone" = 1; 
         "net.ipv4.tcp_window_scaling" = true;
         "net.ipv4.conf.all.forwarding" = true;
         };
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
  #time.timeZone = "Australia/Sydney";
 
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


  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber = {
        #extraConfig = {
        #        "stream.conf" = {
        #                "stream.rules" = [
        #                        {
        #                          matches = [
        #                             { "media.class" = "Stream/Input/Video"; }
        #                          ];
        #                          actions = {
         #                           update-props = {
#        #                               "target.object" = "v4l2_input.pci-0000_00_14.0-usb-0_5_1.0";
         #                               "target.object" = "v4l2_input.pci-0000_00_14.0-usb-0_9_1.0";
         #                           };
         #                         };
         #                       }
         #               ];
         #       };
        #};
        enable = true;
    };
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

  #boot.tmp.useTmpfs = true;
  system = {
#       kernelPackages = unstable.system.linuxPackages_latest;
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
