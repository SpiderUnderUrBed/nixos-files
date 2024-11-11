{ pkgs, lib, specialArgs, ... }:
#let keychain = pkgs.writeShellApplication {
#       name = "keychain";
#       runtimeInputs = [ pkgs.keychain ];
 #       text = "keychain --eval --agents ssh id_ecdsa_sk --timeout 5";  
#    };
# in
let keychain = "null"; 
# nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {};
in
{
 # imports = lib.attrValues nur.repos.moredhel.hmModules.rawModules;
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "23.11";
  home.packages = [
    # (import ./modules/wallpaper-changer  { folder = "./wallpapers"; })
  ];
#  services.unison = {
#    enable = lib.mkOverride true;
#    profiles = {
#      org = {
#        src = "/home/moredhel/org";
#        dest = "/home/moredhel/org.backup";
#        extraArgs = "-batch -watch -ui text -repeat 60 -fat";
#      };
#    };
#  };
#  programs.mpv = {
#    enable = true;
##    profiles = {
##      osc="no";
##    };
##    osc=false;
#    config.osc = "no";
#    scripts = builtins.attrValues {
#      inherit
#        (pkgs.mpvScripts)
#        sponsorblock
#        thumbfast
#        mpv-webm
#        uosc
#        ;
#    };
#}; 
#  programs.mpv = {
 #   enable = true;
#    config.osc = "no";
 #   scripts = [ pkgs.mpvScripts.thumbfast ];
#  };  
#  global-keybind = {
#   enable = true;
#   device = "/dev/input/event0";
#   display = ":1";
#   key_to_press = 125;
#   key_to_send = "Super_L";
#  };
#dconf = {    
#     settings = {
#      "org/virt-manager/virt-manager/connections" = {
#           autoconnect = ["qemu:///system"];
#           uris = ["qemu:///system"];
#          };
#         };
#      };
 
 programs = {
#dconf = {    
#     settings = {
#      "org/virt-manager/virt-manager/connections" = {
#          autoconnect = ["qemu:///system"];
#          uris = ["qemu:///system"];
#         };
#        };
#      };
#       }
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    mpv = {
       enable = true;
#    profiles = {
#       osc="no";
#    };

#    osc=false;
        config.osc = "no";
        scripts = builtins.attrValues {
          inherit
            (pkgs.mpvScripts)
            sponsorblock
            thumbfast
            mpv-webm
            uosc
            ;
        };
   
    }; 
    git = {
        enable = true;
#       extraConfig = {
#         credential.helper = "${
#         pkgs.override { withLibsecret = true; }
#        }/bin/git-credential-libsecret";
#       };
#       package = pkgs.gitFull;
#       config.credential.helper = "libsecret";
        extraConfig = {
          credentialStore = "secretservice";
          helper = "${specialArgs.gitCredentialManager}"
#         helper = "${specialArgs.nurPkgs.repos.utybo.git-credential-manager}/bin/git-credential-manager-core";
        };
    };
    librewolf = {
        enable = false;
#       nativeMessagingHosts = [ pkgs.plasma-browser-integration ];
   };
    bash = {
      enable = true;
      bashrcExtra = ''
#        eval $(ksuperkey)
        alias nix-gc='nix-collect-garbage'
        alias facer='/etc/nixos/acer-predator-turbo-and-rgb-keyboard-linux-module/facer_rgb.py'
        if not [ ! -x /bin/sudo ]; then
    #           alias sudo='/bin/sudo'
        #else
                alias sudo='/run/wrappers/bin/sudo'
        fi

        #alias sudo='/run/wrappers/bin/sudo'
        export PATH=$PATH:/home/spiderunderurbed/.cargo/bin
        eval $(thefuck --alias)
        eval "$(zoxide init bash)"
        #eval ()
#       clear
        hyfetch
#       ##${keychain}/bin/keychain
#        . ~/oldbashrc
      '';
    };
   nix-revsocks = {
        enable = true;
        instances."first instance".connect = "192.168.68.77";
    };
  #  wallpaper-changer = {
  #    enable = true;
  #    folder = "test";
  #  };
#    plasma = {
#      enable = true;
#      workspace = {
#        clickItemTo = "select";
#        lookAndFeel = "YaruPlasma.V1.Plasma6";
#       # cursorTheme = "Bibata-Modern-Ice";
#       # iconTheme = "papirus-icon-theme";
#        wallpaper = "/home/spiderunderurbed/test2.png";
#      };
#      hotkeys.commands = {
#        "yakuake" = {
#          key = "Meta+`";
#          command = "yakuake";
#        };
#      };
#      shortcuts = {
#        ksmserver = {
#          "Lock Session" = [ "Screensaver" "Meta+Ctrl+Alt+L" ];
#        };
#        kwin = {
#          "Expose" = "Meta+,";
#          "Switch Window Down" = "Meta+J";
#          "Switch Window Left" = "Meta+H";
#          "Switch Window Right" = "Meta+L";
#          "Switch Window Up" = "Meta+K";
#        };
#      };
 #     configFile = {
#        "baloofilerc"."Basic Settings"."Indexing-Enabled" = false;
#        "kwinrc"."org\\.kde\\.kdecoration2"."ButtonsOnLeft" = "SF";
#       "kwinrc"."ModifierOnlyShortcuts"."Meta" = "org.kde.plasmashell,/PlasmaShell,org.kde.PlasmaShell,activateLauncherMenu"; 
#"org.kde.lattedock,/Latte,org.kde.LatteDock,activateLauncherMenu";
#      };
 
  #   utils.kconfig.files.kwinrc.items = [
   #     (mkItem "ModifierOnlyShortcuts" "Meta" "org.kde.lattedock,/Latte,org.kde.LatteDock,activateLauncherMenu")
   #   ];

    #  utils.kconfig.files.lattedockrc.items = [
   #     (mkItem "General" "Number of Actions" "0")
   #     (mkItem "PlasmaThemeExtended" "outlineWidth" "1")
   #     (mkItem "UniversalSettings" "badges3DStyle" "false")
   #     (mkItem "UniversalSettings" "canDisableBorders" "true")
   #     (mkItem "UniversalSettings" "contextMenuActionsAlwaysShown" "_layouts,_preferences,_quit_latte,_separator1,_add_latte_widgets,_add_view")
   #     (mkItem "UniversalSettings" "inAdvancedModeForEditSettings" "true")
   #     (mkItem "UniversalSettings" "inConfigureAppletsMode" "true")
   #     (mkItem "UniversalSettings" "isAvailableGeometryBroadcastedToPlasma" "true")
   #     (mkItem "UniversalSettings" "launchers" "")
   #     (mkItem "UniversalSettings" "memoryUsage" "0")
   #     (mkItem "UniversalSettings" "metaPressAndHoldEnabled" "false")
   #     (mkItem "UniversalSettings" "mouseSensitivity" "2")
   #     (mkItem "UniversalSettings" "parabolicSpread" "3")
   #     (mkItem "UniversalSettings" "parabolicThicknessMarginInfluence" "1")
   #     (mkItem "UniversalSettings" "screenTrackerInterval" "1000")
   #     (mkItem "UniversalSettings" "showInfoWindow" "true")
   #     (mkItem "UniversalSettings" "singleModeLayoutName" "MyDock")
   #     (mkItem "UniversalSettings" "version" "2")
  #    ];

 #     environment.overlay = mkOverlayTree user {
 #       lattedockrc = {
 #         target = c "lattedockrc";
 #         source = config.utils.kconfig.files.lattedockrc.path;
 #       };
#      };

#      environment.persistence = mkPersistDirsTree user [
#        (c "latte") (ls "latte")
#      ];
#    };
  };
}
