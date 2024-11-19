
#last | grep "still logged in"# Edit this configuration file to define what should be installed o
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:

#nixpkgs.overlays = [
#(import /etc/nixos/waydroid-overlay.nix)
#];

#nixpkgs.overlays = [(final: prev: {
 #   jellyfin-ffmpeg = final.callPackage ../../pkgs/jellyfin-ffmpeg {};
#})];
#
#hardware.bluetooth.enable = true; # enables support for Bluetooth
#hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
#sudo nixos-rebuild switch
#environment.systemPackages = with pkgs; [
  # Other packages...
 # gparted
#];
#services.bluez = {
# enable = true;
#};
#
#environment.variables = {
#letw
# raspberry_pi_ip = $(tailscale status | awk '$2 == "raspberrypi" {print $1}');
#};

/* let dnskeys = pkgs.writeText "dnskeys.conf" 
''
'';
pebbleConfig = pkgs.writeText "pebble.json" (builtins.toJSON {
  pebble = {
   listenAddress = "0.0.0.0:14000";
     managementListenAddress = "0.0.0.0:15000";
     certificate = "/etc/letsencrypt/live/demos123.com/fullchain.pem";
     privateKey = "/etc/letsencrypt/live/demos123.com/privkey.pem";
    # privateKey = "/etc/nixos/certs/key.pem";
    #	certificate = "/etc/nixos/certs/cert.pem";
    # certificate = "${pkgs.pebble.src}/test/certs/localhost/cert.pem";
     # privateKey = "${pkgs.pebble.src}/test/certs/localhost/key.pem";
      httpPort = 5002;
      tlsPort = 5001;
      ocspResponderURL = "";
      externalAccountBindingRequired = false;
    };
  });
headscaledemocom = pkgs.writeText "demos123.com"
''
$ORIGIN demos123.com.
$TTL 1d
ns1  IN  A	0.0.0.0

@  IN  SOA  ns1.demos123.com. admin.demos123.com. (
    2024011402  ; Serial
    1h          ; Refresh
    15m         ; Retry
    1w          ; Expire
    3h          ; Negative Cache TTL
)

@  IN  NS  ns1.demos123.com.
'';
named = pkgs.writeText "named.conf" ''
options {
    directory "/etc/powerdns/bind";
};
zone "demos123.com" {
    type master;
    file "${headscaledemocom}";  # Adjust the path as needed
    allow-update { none; };
};
'';

domain = "demos123.com";
PDNS_API_KEY="ce3d5b4c6bc08a0057244149e1d8716c6008916b66a5cc8f4ee875a56bf51a4b";
PDNS_API_URL="http://localhost:8000"; 
pdnscreds = pkgs.writeText "pdns.creds" 
''
PDNS_API_KEY="${PDNS_API_KEY}
PDNS_API_URL=${PDNS_API_URL}	
'';
pdnsconf = pkgs.writeText "pdns.conf"
'';

#local-port=54
#launch=gmysql
#gmysql-host=localhost
#gmysql-user=pdns
#gmysql-password=your_password
#gmysql-dbname=pdns
'';
mysqlconf = pkgs.writeText "mysql.conf"
''
[client]
user=pdns
password=teleport
'';
enable_bind = true; */
#domain = "myheadscale.demo.com";
#in
#this = {
#domain = "myheadscale.demo.com";

#  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
let 
#home-manager = pkgs.fetchFromGitHub {
#owner = "nix-community";
#repo = "home-manager";
#rev = "888eac32bd657bfe0d024c8770130d80d1c02cd3";
#sha256 = "0kj49bdl67d1yf5wvqfcrlhf13jmqgvrl33k2bscw1crinab9na9";
#};
  #inputs = inputs
#  unstable = import (builtins.fetchTarball {
#    url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
#  }) {config = config.nixpkgs.config;};
#  nix-software-center = import (pkgs.fetchFromGitHub {
#    owner = "snowfallorg";
#    repo = "nix-software-center";
#    rev = "0.1.2";
#    sha256 = "xiqF1mP8wFubdsAQ1BmfjzCgOD3YZf7EGWl9i69FTls=";
# }) {pkgs = unstable;};
#  raspberry_pi_ip = pkgs.writeText "raspberry_pi_ip.txt" ''
#    ${pkgs.tailscale}/bin/tailscale status | awk '$2 == "raspberrypi" {print $1}'
#  '';
  #shellHookScript = pkgs.writeText "get-raspberry-pi-ip.sh" ''
    #!/bin/sh
    #set -e
   # tailscale status | awk '$2 == "raspberrypi" {print $1}' > /etc/nixos/raspberry_pi_ip.txt
  #'';
#   raspberry_pi_ip = pkgs.stdenv.mkDerivation {
#    name = "raspberry_pi_ip";
   # buildCommand = ''
      # Run your command here
    #  $(tailscale status | awk '$2 == "raspberrypi" {print $1}')"
    #'';
#  };
   # 
  # test = (import <nixpkgs> {}).runCommand "test" {} ''
  #      mkdir $out
  #	echo test
  # '';
  #pre-igpu = (import <nixpkgs> {}).runCommand "igpu" {} "${script}/bin/env-vars.sh  > $out";
  #igpu = builtins.readFile pre-igpu;
#  igpu = (import <nixpkgs> {}).runCommand "igpu" {} ''
#	realpath /dev/dri/by-path/pci-0000\:00\:02.0-card
  #'';
  #card = exec ["realpath /dev/dri/by-path/pci-0000:00:02.0-card"];
  #igpu = (import <nixpkgs> {}).runCommand("realpath /dev/dri/by-path/pci-0000\:00\:02.0-card" {} "realpath /dev/dri/by-path/pci-0000\:00\:02.0-card");
 # igpu = import (import <nixpkgs> {}).runCommand "realpath /dev/dri/by-path/pci-0000\:00\:02.0-card" {} "realpath /dev/dri/by-path/pci-0000\:00\:02.0-card");
 # nixpkgs = import <nixpkgs> {};
#  envycontrol = pkgs.nixpkgs.lib.mkFlake {
#    src = nixpkgs.lib.cleanSourceWith {
#      name = "envycontrol";
#      src = builtins.fetchTarball {
#        url = "https://github.com/bayasdev/envycontrol/archive/main.tar.gz";
#      };
#    };
#  }; 
# python = pkgs.vscode-utils.buildVscodeMarketplaceExtension rec {
#    mktplcRef = {
#      name = "python";
#      version = "2024.15.2024091801";
#      publisher = "ms-python";
#    };
#    vsix = builtins.fetchurl {
#      #url = "/home/spiderunderurbed/ms-python.python.vsix";
#      url = "file:///home/spiderunderurbed/ms-python.python.vsix";
#      sha256 = "d425c4a32528ea96059df4e85656f6fa5234c127f1c60ed2e11b6b2d225209c8";
#      #unpack = false; 
#      dontUnpack = true;
#    };
    #dontUnpack = true;
 # };
    # Add unzip to build inputs
  #  buildInputs = [ pkgs.unzip ];

    # Custom unpackPhase to handle .vsix files
     #   unpackPhase = ''
    #  echo "Unzipping VSIX file..."
      # Create a temporary log file for capturing the output
   #   local logFile="$TMPDIR/unzip.log"

      #mv $vsix 
      # Unzip and append output to the log file
      #unzip "$vsix" -d "$sourceRoot" 
#2>&1 | tee -a "$logFile"

      # Print the contents of the log file
     # echo "Unzip output:"
     # cat "$logFile"
    #'';
 #  unpackPhase = ''
#	mv "$vsix" "${vsix}.zip"
#	unzip -o "${vsix}" -d "$sourceRoot"

	# Unzip the renamed ZIP file to the specified source root directory
#	unzip "${vsix}.zip" -d "$sourceRoot"
#      mv $vsix {vsix}.zip
#      unzip ${vsix}.zip -d $sourceRoot 
#> /home/spiderunderurbed/python.log
   # '';
  #};
# hyprlandConfig = { inherit (import ./hyprland.nix); };
 #hyprlandConfig = ((import ./hyprland.nix).hyprlandConfig) // { enable = false; };
  #hyprlandConfig = ((import ./hyprland.nix) {config, lib, pkgs}).hyprlandConfig // {enable = false;};
  #hyprlandConfig = ((import ./hyprland.nix) { config = config; lib = lib; pkgs = pkgs; }).hyprlandConfig // { enable = false; };
  hyprlandConfig = ((import ./hyprland.nix) { lib = lib; pkgs = pkgs; }) // { enable = false; };
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
 # nix-gaming = import (builtins.fetchTarball "https://github.com/fufexan/nix-gaming/archive/master.tar.gz");
startup = pkgs.writeShellApplication {
  name = "startup";
  runtimeInputs = [];
  text = ''
#       mkdir -p /mnt/btrfs-pool &&
#       mount -o subvolid=0 UUID=0095faf2-2359-4515-a1e1-af7ef6f11a0f /mnt/btrfs-pool 
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
#    mkdir -p /mnt/btrfs-pool &&
#    mount -o subvolid=0 UUID=0095faf2-2359-4515-a1e1-af7ef6f11a0f /mnt/btrfs-pool &&
    screen -S arion_session -d -m nix-shell -p arion --run "arion -p /etc/nixos/arion-pkgs.nix -f /etc/nixos/arion-compose.nix up"
  '';
};
#waydroid-net = (builtins.readFile ./waydroid-net.sh);
 #  pkgs-nvidia = import
 #   (
 #     builtins.fetchTarball "https://github.com/nixos/nixpkgs/tarball/71e91c409d1e654808b2621f28a327acfdad8dc2"
 #   )
 #   { };
    aagl = import (builtins.fetchTarball "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz");
#  myPipe = pkgs.runCommand "my-pipe" {} ''
#    mkfifo $out
#    echo $out
#    cat $out
#  '';
#   myPipe = pkgs.runCommand "my-pipe" {} ''
#    mkfifo $out
#    exec systemctl start env-vars.service > $out 2>&1 &
#    wait
#  '';
#  startup = pkgs.writeShellApplication {
#       name = "realpath";
#       runtimeInputs = [ 
       #realpath
#       ];
#  };
#  script = pkgs.writeScriptBin "env-vars" ''
#    realpath /dev/dri/by-path/pci-0000:00:02.0-card
#  '';

#  pre-igpu = (import <nixpkgs> {}).runCommand "igpu" {
#      useSandbox = false;
##     sandboxPaths = [ "/dev" ];
#  } ''
#    ${script}/bin/env-vars > $out
#  '';

#  igpu = builtins.readFile pre-igpu;
 # startup = pkgs.writeShellApplication {
 # name = "startup";
#  runtimeInputs = [ pkgs.python311Packages.pip pkgs.python3 pkgs.docker pkgs.nix pkgs.arion ];

  # Build the script dynamically
#  text = ''
    # Create a virtual environment
#    python3 -m venv "$out"/venv#

#    # Activate the virtual environment and install packages
#    source "$out"/venv/bin/activate
#    pip install docker-py
#    arion build
#    arion up
#  '';
#};


 # script = pkgs.writeScriptBin "env-vars.sh" ''
	#!/bin/sh
# 	realpath /dev/dri/by-path/pci-0000\:00\:02.0-card
       # export KWIN_DRM_DEVICES=$(realpath /dev/dri/by-path/pci-0000\:00\:02.0-card)
#  '';
#  myPipe = pkgs.runCommand "my-pipe" {} ''
#    mkfifo $out
#    exec systemctl start env-vars.service > $out 2>&1 &
#    wait
#  '';
#  nix-shell -p coreutils
 
   #nvidia-offload = pkgs.writeShellScriptBin "wnvidia-offload" '' 
   #  export __NV_PRIME_RENDER_OFFLOAD=1 
   #  export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0 
   #  export __GLX_VENDOR_LIBRARY_NAME=nvidia 
   #  export __VK_LAYER_NV_optimus=NVIDIA_only 
   #  exec "$@" 
   #''; 
 
  nix-software-center = import (pkgs.fetchFromGitHub {
    owner = "snowfallorg";
    repo = "nix-software-center";
    rev = "0.1.2";
    sha256 = "xiqF1mP8wFubdsAQ1BmfjzCgOD3YZf7EGWl9i69FTls=";
  }) {};
  concatMapStringsSep = { sep, f, list }:
    builtins.concatStringsSep sep (map (x: f x + "\n") list);
in 
#}
{
nixpkgs.config.allowUnsupportedSystem = true;
nixpkgs.overlays = [
pinnedKde
#(import /etc/nixos/waydroid-overlay.nix { inherit pkgs lib config; })
];

aagl.enableNixpkgsReleaseBranchCheck = false;

# nixpkgs.config.packageOverrides = pkgs: {
#    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
#      inherit pkgs;
#    };
#  };
#raspberry_pi_ip = pkgs.stdenv.mkDerivation {
 # name = "raspberry_pi_ip";
 # buildCommand = "${buildScript}";
#};
# raspberry_pi_ip = pkgs.stdenv.mkDerivation {
#    name = "raspberry_pi_ip";
#    buildCommand = ''
#      # Run your command here
#      echo "$(tailscale status | awk '$2 == "raspberrypi" {print $1}')" > $out
#    '';
#  };
#modules = [ arion.nixosModules.arion ];
#  nixpkgs.overlays = [ (self: super: (let
#    patched_pkgs = import inputs.nixpkgs_patched {
#      inherit (self) system;
#      config.allowUnfree = true;
#    };
#  in {
#    linuxPackages = patched_pkgs.linuxPackages;
#  })) ];
  #hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  #hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  #wboot.kernelPackages = pkgs.linuxPackages;
#imports = [
  #  ./hardware-configuration.nix
 #   (import "${this.home-manager}/nixos")
 # ];
 #programs.home-manager.enable = true;
 #home-manager.users.spiderunderurbed = {
 # home.stateVersion = "18.09";
 #};

#  systemd.services."acme-demo.com" = {
 #   after = ["pdns.service"];  # Ensure PDNS is started before attempting renewal.
 #   script = ''
  #    export PDNS_API_URL="http://localhost:8000"  # Adjust this to your actual PDNS API URL.
  #    export PDNS_API_KEY="ce3d5b4c6bc08a0057244149e1d8716c6008916b66a5cc8f4ee875a56bf51a4b"  # Adjust this to your actual PDNS API key.
  #    exec ${pkgs.lego}/bin/lego --accept-tos --path . -d demo.com --email SpiderUnderUrBed@proton.me --key-type ec256 --dns pdns --dns.resolvers localhost:53 --server https://localhost:14000 run
  #  '';
    # ... other service configurations ...
 # };
#systemd.services."acme-demo.com".serviceConfig.Environment = [
#"PDNS_API_URL=http://localhost:8000" 
#"PDNS_API_KEY=ce3d5b4c6bc08a0057244149e1d8716c6008916b66a5cc8f4ee875a56bf51a4b"
#];
#systemd.services.snort = {

#}
#systemd.enableUnifiedCgroupHierarchy = false;

#  myPipe = pkgs.runCommand "my-pipe" {} ''
#    mkfifo $out
#    cat $out
#  '';

  #igpuWithPipe = builtins.readFile myPipe;
systemd = {
user.services = {
"pasystray-ensure" = {
    description = "PulseAudio Tray Application (pasystray)";
 #   after = [ "graphical.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash -c 'if ! ${pkgs.procps}/bin/pgrep pasystray > /dev/null; then ${pkgs.pasystray}/bin/pasystray --display=:0; fi'";
      Restart = "always";
    };
 #   wantedBy = [ "default.target" ];
};
};
services = {
#<<<<<<< HEAD
#waydroid-container.wantedBy = lib.mkForce [];
#"app-org.kde.xwaylandvideobridge@autostart.service".wantedBy = lib.mkForce [];
#=======
#waydroid-container.wantedBy = lib.mkForce [];
#>>>>>>> cdcb124 (Initial commit)
#export KWIN_DRM_DEVICES=$(realpath /dev/dri/by-path/pci-0000\:00\:02.0-card)
#env-vars = {
#    wantedBy = ["multi-user.target"];
#    serviceConfig.ExecStart = ''
# 	/bin/sh ${script}/bin/env-vars
#      export KWIN_DRM_DEVICES=$(realpath /dev/dri/by-path/pci-0000\\:00\\:02.0-card)
#       exit $?
#    '';
#  };
#tailscale-up = {
#    after = ["arion-tailscale.service"];
#    wantedBy = ["multi-user.target"];
#    requires = ["arion-tailscale.service"];
#    serviceConfig.Type = "oneshot";
#    serviceConfig.ExecStart = ''
#      ${pkgs.docker}/bin/docker exec tailscaled tailscale &&  ${pkgs.docker}/bin/docker exec tailscaled tailscale up --authkey=tskey-auth-keAyTP5CNTRL-7SeWhLQXXK7ioVUh7dJQK7ceZBeS7n5h 
#--socket /var/lib/tailscale-fake.sock
#    '';
#    serviceConfig.ExecStartPre = ''
      #${pkgs.coreutils}/bin/sleep 5
#    '';`
#  };
#};
#cron = {
#enable = true;
#systemCronJobs = [
#"*/5 * * * *	root	/etc/nixos/persist.sh"
#]
#}
#ssh-inhibit-sleep = {
 #description = "Check for running SSH sessions and, if any, inhibit sleep";
# before = "sleep.target";
# serviceConfig = {
#   Type = "oneshot"; 
#   ExecStart="/bin/sh -c '! who | grep -qv "\(:0\)"'"
#  };
#  requiredBy = "sleep.target";  
#};
#snort = {
#  description = "Snort service";
#  after = [ "syslog.target" "network.target" ];
#  serviceConfig = {
#    Type = "simple";
#    EnvironmentFile = pkgs.writeText "snort.conf" ''
#    '';
#    PIDFile = "/var/run/snort/snort1.pid";
#    ExecStartPre = [
#      "-/usr/sbin/ethtool -K $INTERFACE rx off tx off gro off lro off"
#      "-/usr/sbin/ip link set arp off multicast off promisc on dev $INTERFACE"
#    ];
#    ExecStart = "/usr/sbin/snort -D -u snort -g snort -c $CONF -i $INTERFACE -R 1 --pid-path=/var/run/snort --no-interface-pidfile --nolock-pidfile";
#    KillMode = "process";
#  };
#  wantedBy = [ "multi-user.target" ];
#};
};
};
/* systemd.services."pdns.service.d".after = ["mysql.service"];
systemd.services.pebble = {
    description = "Pebble ACME Test Server";
    after = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      AmbientCapabilities="CAP_DAC_READ_SEARCH";
      Environment = [ "PEBBLE_VA_NOSLEEP=1" "PEBBLE_VA_ALWAYS_VALID=1" ];
      ExecStart = "${pkgs.pebble}/bin/pebble -config ${pebbleConfig}";
      DynamicUser = true;
    };
  }; */
#
#systemd.services."acme-demo.com.service" = {
#enable = false;
##after = "pdns.service.d";
#serviceConfig.Environment = [
#"LEGO_CA_CERTIFICATES=/etc/nixos/certs/cert.pem" 
#"LEGO_CA_SERVER_NAME=localhost"
#];
#};
#security.pki.certificateFiles = ["/home/spiderunderurbed/crt/headscale.crt"];
security.sudo.enable = true;
#security.rtkit.enable = true;
security.pki.certificates = [ ''
#-----BEGIN CERTIFICATE-----
#MIIDCTCCAfGgAwIBAgIIJOLbes8sTr4wDQYJKoZIhvcNAQELBQAwIDEeMBwGA1UE
#AxMVbWluaWNhIHJvb3QgY2EgMjRlMmRiMCAXDTE3MTIwNjE5NDIxMFoYDzIxMTcx
#MjA2MTk0MjEwWjAgMR4wHAYDVQQDExVtaW5pY2Egcm9vdCBjYSAyNGUyZGIwggEi
#MA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC5WgZNoVJandj43kkLyU50vzCZ
#alozvdRo3OFiKoDtmqKPNWRNO2hC9AUNxTDJco51Yc42u/WV3fPbbhSznTiOOVtn
#Ajm6iq4I5nZYltGGZetGDOQWr78y2gWY+SG078MuOO2hyDIiKtVc3xiXYA+8Hluu
#9F8KbqSS1h55yxZ9b87eKR+B0zu2ahzBCIHKmKWgc6N13l7aDxxY3D6uq8gtJRU0
#toumyLbdzGcupVvjbjDP11nl07RESDWBLG1/g3ktJvqIa4BWgU2HMh4rND6y8OD3
#Hy3H8MY6CElL+MOCbFJjWqhtOxeFyZZV9q3kYnk9CAuQJKMEGuN4GU6tzhW1AgMB
#AAGjRTBDMA4GA1UdDwEB/wQEAwIChDAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYB
#BQUHAwIwEgYDVR0TAQH/BAgwBgEB/wIBADANBgkqhkiG9w0BAQsFAAOCAQEAF85v
#d40HK1ouDAtWeO1PbnWfGEmC5Xa478s9ddOd9Clvp2McYzNlAFfM7kdcj6xeiNhF
#WPIfaGAi/QdURSL/6C1KsVDqlFBlTs9zYfh2g0UXGvJtj1maeih7zxFLvet+fqll
#xseM4P9EVJaQxwuK/F78YBt0tCNfivC6JNZMgxKF59h0FBpH70ytUSHXdz7FKwix
#Mfn3qEb9BXSk0Q3prNV5sOV3vgjEtB4THfDxSz9z3+DepVnW3vbbqwEbkXdk3j82
#2muVldgOUgTwK8eT+XdofVdntzU/kzygSAtAQwLJfn51fS1GvEcYGBc1bDryIqmF
#p9BI7gVKtWSZYegicA==
#-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIGPzCCBCegAwIBAgIUeINQ75LPcCLI7cKU1U8S9SyIIb0wDQYJKoZIhvcNAQEL
BQAwgZsxCzAJBgNVBAYTAk5aMRMwEQYDVQQIDApTb21lLVN0YXRlMRMwEQYDVQQH
DApXZWxsaW5ndG9uMSEwHwYDVQQKDBhJbnRlcm5ldCBXaWRnaXRzIFB0eSBMdGQx
FDASBgNVBAMMC3NwaWRlcnNjYXZlMSkwJwYJKoZIhvcNAQkBFhpTcGlkZXJVbmRl
clVyQmVkQHByb3Rvbi5tZTAeFw0yNDAxMjMwMTI4MzJaFw0yNTAxMjIwMTI4MzJa
MIGbMQswCQYDVQQGEwJOWjETMBEGA1UECAwKU29tZS1TdGF0ZTETMBEGA1UEBwwK
V2VsbGluZ3RvbjEhMB8GA1UECgwYSW50ZXJuZXQgV2lkZ2l0cyBQdHkgTHRkMRQw
EgYDVQQDDAtzcGlkZXJzY2F2ZTEpMCcGCSqGSIb3DQEJARYaU3BpZGVyVW5kZXJV
ckJlZEBwcm90b24ubWUwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQC+
zY/0WQ//hiPOv7NpY4YAB0cBqajg9YKh/s5C63TDaU9yjKrGJTSDPj0lvs+ofP+1
I14rsJvdiDP3JKQJ6efEUkDJgQZrKLF9HFDB3WahdgCRyq48CMPuTZG9T1I8s5Bs
kPAGHI8E5heszWh8yqpqmTfK4U+7Y9p3ej9kiQURmx5fUH4sF+tdBSax6vqp2aVT
62x0dNCUhRJ9QRVPYWOZ/d7K4MSFlrR29TmncoZ0XJz2z0Ve7AwFkVeRGABeK6K4
SfpWcENbzri8gL4rcEZgHOOTK0X4vL4gToRkk5lcIjnkj/m1UY1ZmG5BhwXTYm6B
jlpxahByCQZgi9tpuYwZeC+6eNSC2hyr8shqEYqBcSOoNglWlCID0A24Ve7KwCth
1SHPTPhcVZRgQ1JrTjYHes1STAJiCi5TJXGze5wDg7muADo2gkfr1o6WeNaIu8c2
b5/t39KoISoM7CGQEyEVD8Mv5lZCrmc+o+HFVVcItmLvORz5+DDQBWmJv/94LMxA
hnY8c3giokFIb+71KVaPEwETujqCKR+n8+c876Qc532lTKnaVR0bWJdcl472NQMk
VzedjY/PKjJxE5VAxub0uvOug4nDeMeGhtzk2FKcUe997qNk/3urUwkSvK8CXA2Z
Pyn9lDoIfSL6dy4P7PWQ5eQjiFUC4FI4aJWO48T34QIDAQABo3kwdzAdBgNVHQ4E
FgQUsErcaMns2Yegkxn+dunfLtqPIHUwHwYDVR0jBBgwFoAUsErcaMns2Yegkxn+
dunfLtqPIHUwDwYDVR0TAQH/BAUwAwEB/zAkBgNVHREEHTAbgghkZW1vLmNvbYIJ
bG9jYWxob3N0hwR/AAABMA0GCSqGSIb3DQEBCwUAA4ICAQC2y5ublo3Yi814beLE
Pe9pUVfyQJPzs5KKPjQM0yX+aL+gMUO9WdHZad+Qnyi6jCjb17O5L81650gt0Tb3
ZGm43CqbRvmUmJXrvJ0kPit4EW1XXGshgx4ht6nCJMzuCuDvwn0dqXycm4QSGwrW
PItlLaul4Ev/wnYUy+FCLS4iKm4+UQhUkdYf+kXbEYkYYFeGCaJ665OVRkBPqcSR
fD5BRROGnI56qyVLsuDcfGU5e6r2y3N1+bQNpokFUvyhJGcTol+0Bw9HC0nY4z28
ebu11AfvMSFCwm8FnuvFkzsi7rqcc4HZNJK4YX3yYrzXFAVFTzp1YUZ30BOqGcX4
2SJkgzJD/oLToXu4dL9mBcDZTTVp6vpHJb29634eIg6vZPL3m0ArsBRKRW3ubznI
GHredzIW5VGJsFEHIszfemGqaM9McSAzPcJKpm51CtjJ0KRcnUO8vaFYuuxMpGEy
lxxcvWBAjeNJ3fvBMIoagrgxbJastRcaNaNG+HV0UvXueIp3HtZ5zP5nc1Vc8+Rh
P+fPL1Z4EQJi6HqKWNlXBDiKThzuqx9PbwrPvslGz+Eo+nIXmOGyLaj0qvJNKYBs
MfgyO7oEXySSP4smoUn5isKWg3B5z6nQ7ReXzq/XkZoFhXq3gOGiSILOwI/adra7
hCncJu0OBrcLizP9UYJmH+7iVg==
-----END CERTIFICATE-----
'' ];
networking = { 
#wireless.iwd.package = [
#<derivation iwd-2.13>
#];

#interfaces."enp44s0".wakeOnLan = {
#enp46s0
interfaces."enp46s0".wakeOnLan = {
#policy = "";
enable = true;
};
nameservers = [
"8.8.8.8" 
#"localhost" 
"100.100.100.100"]; 
#};
};
#security.acme = {
#  server = "https://localhost:14000/dir";
#  preliminarySelfsigned = true;
#  acceptTerms = true;
# email = "SpiderUnderUrBed@proton.me";
#   certs."example.com" = {
#        webroot = "/var/www/example.com";
#        group = "nginx";
#      };
#  certs."demos123.com" = {
#  environmentFile = pkgs.writeText "legovar.conf" ''
#	PDNS_API_KEY="ce3d5b4c6bc08a0057244149e1d8716c6008916b66a5cc8f4ee875a56bf51a4b"
#	PDNS_API_URL="http://localhost:8000"
#  '';
#    dnsProvider = "pdns";
#    dnsResolver = "localhost:53"; # This should be pdns.
#   dnsPropagationCheck = true;
#   # credentialsFile = pdnscreds;
# webroot = "/var/lib/acme/challenges-de";
#  group = "nginx";
#   email = "SpiderUnderUrBed@proton.me";
#  };
#  certs."headscale.demo.com" = {
#    dnsProvider = "pdns";
#  dnsResolver = "localhost:53"; # This should be pdns.
#   dnsPropagationCheck = true;
#    credentialsFile = pdnscreds;
#  # webroot = "/var/lib/acme/challenges-de";
#    group = "nginx";
#    email = "SpiderUnderUrBed@proton.me";
#};    
#};
/*
security.acme = {
#enable = false;
server = "https://localhost:14000/dir";
preliminarySelfsigned = true;
acceptTerms = true;
email = "SpiderUnderUrBed@proton.me";
certs."demos123.com" = {
  environmentFile = pkgs.writeText "legovar.conf" ''
       PDNS_API_KEY="ce3d5b4c6bc08a0057244149e1d8716c6008916b66a5cc8f4ee875a56bf51a4b"
       PDNS_API_URL="http://localhost:8000"
  '';
 dnsProvider = "pdns";
 dnsResolver = "localhost:53"; # This should be pdns.
 dnsPropagationCheck = true;
 group = "nginx";
 email = "SpiderUnderUrBed@proton.me";
};
certs."headscale.demo.com" = {
dnsProvider = "pdns";
dnsResolver = "localhost:53";
dnsPropagationCheck = true;
credentialsFile = pdnscreds;
email = "SpiderUnderUrBed@proton.me";
group = "nginx";
};
 # certs."demos123.com" = {
    # Define configuration for demos123.com here if needed
 # };
};
*/
  #environment.systemPackages = [ pkgs.pcsclite ];
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
 # networking.firewall = {
 #   checkReversePath = "loose";
 #   trustedInterfaces = [ "tailscale0" ];
 #   allowedUDPPorts = [ config.services.tailscale.port ];
 # };

services = {
#<<<<<<< HEAD
#=======
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

#>>>>>>> cdcb124 (Initial commit)

#protonmail-bridge = {
#  enable = true;
#  package =
#    # Ensure pass is not in the PATH.
#    pkgs.runCommand "protonmail-bridge"
#      {
#        bridge = pkgs.protonmail-bridge;
#        nativeBuildInputs = [ pkgs.makeWrapper ];
#      }
#      ''
#        mkdir -p $out/bin
#        makeWrapper $bridge/bin/protonmail-bridge $out/bin/protonmail-bridge \
#            --set PATH ${lib.strings.makeBinPath [ pkgs.gnome3.gnome-keyring ]}
#      '';
#};
displayManager = {
   execCmd = lib.mkDefault "exec ${pkgs.sddm}/bin/sddm";
   sessionPackages = [
 	pkgs.hyprland
  ];
  # sessionPackages = [
  #  ((pkgs.writeTextDir "share/wayland-sessions/hyprland.desktop" ''
  #	    [Desktop Entry]
  #          Name=hyprland
  #          Comment=A wayland window manager
  #          Exec=hyprland
  #  	    Type=Application
  #  ''))
  #  ];
};

usbguard = {
#enable = true;

};
beesd.filesystems = {
#root = {
#    spec = "LABEL=root";
#    hashTableSizeMB = 2048;
#    verbosity = "crit";
#    extraOptions = [ "--loadavg-target" "5.0" ];
#  };
main = {
   spec = "LABEL=home";
   hashTableSizeMB = 2048;
   verbosity = "crit";
   extraOptions = [ "--loadavg-target" "5.0" ];
};
};
tlp = {
enable = false;
#enable = true;
};
monero = {
enable = false;
limits.threads=2;
mining = {
enable= false;
address="47XA83EZZvdiBbtJH7oF5UYvzCGFEW94dHFRamPFoaDfjXHJDWHuHHQYP9qDTb2itr3ZijVrTsnn4Vf7gVUdgFEpDicDiZU";
};
};
#monero = {
#enable = true;
#limits.threads=2;
#mining = {
#address="47XA83EZZvdiBbtJH7oF5UYvzCGFEW94dHFRamPFoaDfjXHJDWHuHHQYP9qDTb2itr3ZijVrTsnn4Vf7gVUdgFEpDicDiZU";

#address = 
#};
#};
 # hostapd = {
#   enable = true;
  # wifi6 = true;
#   radios = {
#	wlp3s0 = {

#	}	
#   }
 # }; 
  syncthing = {
        enable = true;
	user = "spiderunderurbed";
	configDir = "/home/spiderunderurbed/syncthing/etc";
	dataDir = "/home/spiderunderurbed/syncthing/data";
   };
   packagekit.enable = true; 
 /*
 flatpak = {
  
   update.onActivation = false;
     remotes = [
	{
	name = "gol"; location = "https://gol.launcher.moe/gol.launcher.moe.flatpakrepo";
	} 
	{
	name = "flathub-beta"; location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
	}
	{
	name = "flathub"; location = "https://flathub.org/repo/flathub.flatpakrepo"; 
	}
	#{
	#name = "kdeapps"; location = "https://distribute.kde.org/kdeapps.flatpakrepo";
	#}
#	{
#	name = "kdeapps"; location = "https://cdn.kde.org/flatpak/kde-runtime-nightly/org.kde.Platform.flatpakref";
#	}
	];
     packages = [
	#{ appId = "org.kde.discover"; origin = "kdeapps"; }
	"moe.launcher.the-honkers-railway-launcher"
	"com.github.tchx84.Flatseal"
	"com.obsproject.Studio"	
	"org.gimp.GIMP"
	#"org.kde.krita"
	#"org.kde.kdenlive"
	{ appId = "moe.launcher.an-anime-game-launcher"; origin = "gol"; }
     ];  
  }; 
*/ 
# pcscd.enable = true;
    #udev = {
     # packages = [
      #  pkgs.yubikey-personalization
     # ];
   # };

   # gpg-agent = {
   # enable = true;
   # enableBashIntegration = true;
   # enableSshSupport = true;
   # pinentryFlavor = "qt";
   # enableScDaemon = true;
   # };	
expressvpn.enable = true;	
 #  acme-dns = {
#	enable = true;
#	settings = {
#		api = {
#			ip = "127.0.0.1";
#			disable_registration = true;
#			port = 13000;
#			
#		};
#		general = {
#		listen = "127.0.0.1:54";
#		domain = "acme-dns.example.com";
#		nsname = "localhost:5300";
#		nsadmin = "SpiderUnderUrBed@proton.me";
#		records = [];
#		};
#	};
#   } ;
  # fail2ban = { 
#	enable = true;
 #   };
/*     headscale = {
#     serviceConfig.BindReadOnlyPaths = [ "/etc/ssl/certs" ];
     enable = true;
     address = "0.0.0.0";
     port = 8080;
     serverUrl = "https://${domain}";
     dns = { baseDomain = "demos123.com"; };
     settings = { logtail.enabled = false; server_url = "https://${domain}"; };
   };

#    nginx.enable = true;
    nginx = {
       enable = false;
       virtualHosts.${domain} = {
##          enable = true;
        forceSSL = true;
           # enableACME = true;
	useACMEHost = "demos123.com";
    locations."/" = {
        proxyPass =
               "http://localhost:${toString config.services.headscale.port}";
       proxyWebsockets = true;
      };
     };
    };
     pdns-recursor = {
	enable = true;
	settings = {
	forward-zones = ''
	.=8.8.8.8,.=127.0.0.1
	'';  	
	};
     };
     powerdns = {
	enable = true;
	extraConfig = ''
	api=yes 	
	launch=bind,gmysql
	 webserver-address=0.0.0.0 
	 webserver-allow-from=0.0.0.0/0 
	 api-key=${PDNS_API_KEY} 
	 local-address=127.0.0.1 
	 local-port=5300  
	 bind-config=${named}
	 bind-check-interval=600
	 gmysql-host=127.0.0.1 
	 gmysql-user=pdns 
	 gmysql-password=teleport 
	 gmysql-dbname=pdns 
	 gmysql-port=3306 
	 gmysql-dnssec=yes
	'';
     };
     powerdns-admin = {
	enable = true;
	saltFile = null;
	secretKeyFile = null;
	config = ''
SQLALCHEMY_DATABASE_URI='mysql://powerdnsadmin:teleport@127.0.0.1:3306/powerdnsadmin'
#local-address=0.0.0.0
#?unix_socket=/run/mysqld/mysqld.sock
BIND_ADDRESS='127.0.0.1'
PORT=8000;
HSTS_ENABLED = False
OFFLINE_MODE = False
SQLALCHEMY_TRACK_MODIFICATIONS = True
     	'';
       };
bind = {
enable = false;

}; */
#   bind = {
#	allowQuery = [ "127.0.0.1" ];  # Allow queries from localhost
 #       allowTransfer = [ "127.0.0.1" ];  # Allow zone transfers from localhost
        #listenOn = [ "127.0.0.1" ];  # Listen on localhost
  #      forwarders = [ "8.8.8.8" "127.0.0.1"];  # Use Google's public DNS as a forwarder (optional)
#	forward = "first";
#	listenOn = 
#	[
#	  "127.0.0.1"
#	];
#	ipv4Only = true;
#	serviceConfig.BindReadOnlyPaths = [ "/etc/ssl/certs" ];
  	#enable = enable_bind;
# 	extraConfig = ''
#    	include dnskeys;
#	'';
  #	zones = [
    #	{
   #  	name = "headscale.demo.com";
#	allowQuery = ["127.0.0.1"];
      #	file = headscaledemocom;
     # 	master = true;
    #  	extraConfig = "allow-update { key pdns.headscale.demo.com.; };";
   # 	}
  #    ];
 #    };
	#};
};
#programs.bash = {
    #enable = true;
 #   shellInit = "export NIXPKGS_ALLOW_INSECURE=1"; 
#   bashrcExtra = ''
 #     . ~/oldbashrc
 #   '';
#};
#programs.kdeconnect.enable = true;
#programs.steam = {
#  enable = true;
#  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
#  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
#};

/* services.mysql = {
  enable = true;
  initialScript = "/etc/nixos/modules/sql-build.sql";
  package = pkgs.mariadb;  # or pkgs.mysql for MySQL

  configFile = pkgs.writeText "mysql.conf" ''
    [client]
    port        = 3306
    socket      = /run/mysqld/mysqld.sock    

    [mysqld]
    general_log = 1
    general_log_file = /var/log/mysql/mysql.log
    max_allowed_packet=256M   
    #database = pdns
    port = 3306
    socket = /run/mysqld/mysqld.sock
   
  '';
   initialDatabases = [
	{name = "pdns";  schema = "/etc/nixos/modules/mysql-schema.sql";}
	{name = "powerdnsadmin"; schema = "/etc/nixos/modules/mysql-schema.sql"; }
   ];
#  ALTER USER 'pdns'@'localhost' IDENTIFIED BY 'teleport';

   ensureDatabases = ["pdns"];

  ensureUsers = [
    {
      name = "pdns";
      ensurePermissions = {
        #"pdns" = "ALL PRIVILEGES";  
        "pdns.domains" = "SELECT, INSERT, UPDATE, DELETE"; 
	"pdns.records" = "SELECT, INSERT, UPDATE, DELETE"; 
	 #"" = "CREATE"; 
	};
    }
    {
	name = "powerdnsadmin";
	ensurePermissions = {
	"powerdnsadmin.*" = "ALL PRIVILEGES";
	#"pdns.domains" = "SELECT, INSERT, UPDATE, DELETE"; 
        #"pdns.records" = "SELECT, INSERT, UPDATE, DELETE"; 
	};
    }
  ];
};
 */

#  services.pcscd.plugins = [ pkgs.ccid	pkgs.gnupg ];
#  environment.shellInit = ''
 #   gpg-connect-agent /bye
  #  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  #'';

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  #system.copySystemConfiguration = true;
 # environment.pathsToLink = [
 #  "${pkgs.jellyfin-ffmpeg.src} /home/jellyfin/jellyfin-ffmpeg"
 # ];
  #environment.etc."jellyfin-ffmpeg" = "${pkgs.jellyfin-ffmpeg.src}";
  environment.systemPackages = with pkgs; 
  [] ++
  [
	#sswg.swift-lang
	#fabric-ai
	#chatgpt-shell-cli
	#yarn
	#waybar
#	blueman-applet
	#hyprland
	#pipx
#	"python3.12-pip-24.0"
	overskride
	hyprland
	anki
	pyenv
	cryfs
	sherlock
	shell-gpt
	feh
	bc
	jq
	pasystray
	copyq
#	xclip
	fortune
	swayosd
	kitty
	pavucontrol
	#nwg-panel
	blueman 
	yt-dlp
	gh
	avml
	volatility3
	wget
	bsd-finger
	pnpm
	#tuxclocker
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
#	weston
	#unigine-heaven
#	envycontrol.packages.x86_64-linux.default
#	nix-gaming.packages.${pkgs.hostPlatform.system}.legendary
	heroic
	gcc
	sl
	cmatrix
	weston
	expressvpn
	rustfmt
#	teleport
	protonmail-bridge
	guake
	cloudflared
	vitetris
	#realvnc-vnc-viewer
	ettercap
	#variety
	audacity
	bottles
	#libglvnd
#	onedrivegui
	vlc
	virt-manager
	bleachbit
#	dwarfdump
	screen
	stacer
	xmrig
	monero-gui
	duperemove
	#rmlint
#	clamtk
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
	#	MS-vsliveshare.vsliveshare 
	 #     MS-vsliveshare.vsliveshare
	 #     python
#file:///home/spiderunderurbed/ms-python.python.vsix
	      svelte.svelte-vscode
	     # Vendicated.vencord-companion
	     (pkgs.vscode-utils.buildVscodeMarketplaceExtension { 
		    mktplcRef = {
     		      name = "python";
		      version = "1.19.1";
	#	      version = "2024.15.2024092301";
		      publisher = "ms-python";
		    };
		    vsix = /home/spiderunderurbed/ms-python-latest.zip;
		   # dontUnpack = true;	   
	       })
	#      (pkgs.vscode-utils.buildVscodeMarketplaceExtension { 
	#	 vsix = "file:///home/spiderunderurbed/ms-python.python.vsix";
	#	})
	      #GregorBiswanger.json2ts
	      ritwickdey.liveserver
	      sswg.swift-lang
	      vadimcn.vscode-lldb
	      bbenoist.nix
      	  #    ms-python.python
	      ms-vscode-remote.remote-containers
	      ms-vscode-remote.remote-ssh
	#      go
	      #golang.go
	      rust-lang.rust-analyzer
	      ms-azuretools.vscode-docker
	      #go.dev
	      #rust-lang.rust-analyzer
	      #GitHub.codespaces
	 #     MS-vsliveshare.vsliveshare
	      eamodio.gitlens
	  ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
		#{
		#name = "python";
		#publisher = "ms-python";
		#version = "2024.15.2024091801";
		#sha256 = "d425c4a32528ea96059df4e85656f6fa5234c127f1c60ed2e11b6b2d225209c8";
		#}
		{
		name = "remove-comments";
		publisher = "plibither8";
		version = "1.2.2";
		sha256 = "ca2ef0e0a937a3da822c849a98c587d280b464287f590883b4febb2ec186d7de";
		}
		{
		name = "vencord-companion";
		publisher = "Vendicated";
		#publisher = "vencord-companion";
		version = "0.1.3";
		sha256 = "9854440646f703deb7a5a1ec3e115a60b7c87c8ea0d17f46bbd45502d5e100e4";
		}
#		{
#		name = "json2ts";
#		publisher = "GregorBiswanger";
#		version = "0.0.6";
#		sha256 = "cf29254cc4bfe5fe9c00bc1e1ee8d6dd68733704528eed0e62a83398dcf1f1e6";
#		}
		{
		 # name = "gitlens";
		  # publisher = "eamodio";
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
#		{
#		name = "vsliveshare";
#		publisher = "Microsoft";
#		version = "1.0.5918"
		
#		}
	  ];
	})
	#python38Packages.mysqlclient
	#pkgs.plasma-discover
	#pkgs.kdenlive
	#libsForQt5.discover
	#libsForQt5.kdenlive
	#keychain
	git-credential-manager
	python3
	logseq
	rage
	onlyoffice-bin
#<<<<<<< HEAD
	vesktop
 #       libreoffice-qt
#=======
#	vesktop
#       libreoffice-qt
#>>>>>>> cdcb124 (Initial commit)
      #  hunspell
      #  hunspellDicts.uk_UA
      #  hunspellDicts.th_TH#
#	hunspellDicts.en-us
#	hunspellDicts.en-us-large
#	aspell.en
	#ksuperkey
	thefuck
	zoxide
	chezmoi
	xorg.xhost
#	proxychains
#	pkgs.proxychains-ng
	latte-dock
	cargo
	rustc 
	nextcloud-client
	keepassxc
	#snort
	prismlauncher
	minicom
#	asciinema
	thunderbird
	yubikey-agent
	yubikey-touch-detector
	age-plugin-yubikey
	yubikey-personalization-gui
	yubikey-manager
#	grapejuice
	godot3
#	unityhub
#	brave
	emacs
#	vscode
	vscodium
	pcscliteWithPolkit.out
	pcsclite  
        gnupg
	#(librewolf.override { extraNativeMessagingHosts = [ libsForQt5.plasma-browser-integration ]; })	
	# (librewolf.override { cfg.enablePlasmaBrowserIntegration = true; })
#	(librewolf.override { })
#	librewolf  
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
	#pkgs.age-plugin-yubikey
	nix-software-center
	nodejs
	#pkgs.
#	inputs.nix-software-center.packages.${system}.nix-software-center
	arion
#	pkgs.jellyfin-ffmpeg
	#environment.systemPackages = with pkgs; [
 # 	(symlinkJoin {
 # 	  name = "jellyfin-ffmpeg";
 # 	  paths = [ jellyfin-ffmpeg ];
  #	  symlink = "/home/jellyfin/jellyfin-ffmpeg";
  #	})
	#];
  ];
#environment.systemPackages = [ pkgs.librewolf ];

virtualisation = {
docker.enable = true;
waydroid.enable = true;
};

#virtualisation.waydroid.config = {
#    assertions = lib.singleton {
#      assertion = lib.versionAtLeast (lib.getVersion config.boot.kernelPackages.kernel) "4.18";
#      message = "Waydroid needs user namespace support to work properly";
#    };#

#    system.requiredKernelConfig = [
#      "ANDROID_BINDER_IPC"
#      "ANDROID_BINDERFS"
#      "MEMFD_CREATE"
#    ];

#    boot.kernelParams = [ "psi=1" ];

#    environment.etc."gbinder.d/waydroid.conf".source = pkgs.writeText "waydroid.conf" ''
#      [Protocol]
#      /dev/binder = aidl2
#      /dev/vndbinder = aidl2
#      /dev/hwbinder = hidl

#      [ServiceManager]
#      /dev/binder = aidl2
#      /dev/vndbinder = aidl2
#      /dev/hwbinder = hidl
#    '';

#    environment.systemPackages = with pkgs; [ waydroid ];
#
#    networking.firewall.trustedInterfaces = [ "waydroid0" ];

#    virtualisation.lxc.enable = true;

#    systemd.services.waydroid-container = {
#      description = "Waydroid Container";
#      wantedBy = [ "multi-user.target" ];
#      serviceConfig = {
#        Type = "dbus";
#        UMask = "0022";
#        ExecStart = "${pkgs.waydroid}/bin/waydroid -w container start";
#        BusName = "id.waydro.Container";
#      };
#    };

#    systemd.tmpfiles.rules = [
#      "d /var/lib/misc 0755 root root -"
#    ];

 #   services.dbus.packages = [ pkgs.waydroid ];
#};
#virtualisation.podman.enable = true;
#virtualisation.podman.dockerSocket.enable = true;
#virtualisation.podman.defaultNetwork.dnsname.enable = true;
#virtualisation.
#arion."chisel".settings.services."chisel" = { config }: {
#virtualisation.arion = {
/*
virtualisation.arion = {
 backend = "docker";
 projects = {
   "tailscale" = {
	settings = {
	 services = {
	   "tailscale".service = {
#command = ["tailscaled --tun=userspace-networking --socks5-server=localhost:1055 --outbound-http-proxy-listen=localhost:1055 --socket=/var/lib/tailscale-fake.sock"];
#"bash -c 'tailscaled --tun=userspace-networking --socks5-server=localhost:1055 --outbound-http-proxy-listen=localhost:1055 --socket=/var/lib/tailscale-fake.sock && tailscale up --socket=/var/lib/tailscale-fake.sock --authkey=tskey-auth-kcFQjy1CNTRL-U6yvZANgnWKqZgCiMwuLWKi9ZY1NPLWi'"];
command = ["/bin/sh" "-c" "tailscaled" "--tun=userspace-networking" "--socks5-server=localhost:1055" "--outbound-http-proxy-listen=localhost:1055"];
#"--socket=/var/lib/tailscale-fake.sock" 
#"&&" "tailscale" "up" "--socket=/var/lib/tailscale-fake.sock" "--authkey=tskey-auth-kcFQjy1CNTRL-U6yvZANgnWKqZgCiMwuLWKi9ZY1NPLWi'"];  
	   #entrypoint = "/bin/sh";
	   container_name="tailscaled";
	   image = "tailscale/tailscale:latest";
	   ports = ["1055:1055"];
           #network_mode = "host";
	   privileged = true;
	   volumes = [
	       "/etc/nixos/tailscale/tailscale-fake.sock:/var/lib/tailscale-fake.sock"
               "/etc/nixos/tailscale/lib:/var/lib"
               "/dev/net/tun:/dev/net/tun"
	       #"/etc/nixos/tailscale"
		];
	    };
	  };
	};	
    };

#environment.variables = { 
#raspberry_pi_ip
   "revsocks" = {
  #`image = "jpillora/chisel"; 
   settings = {
    services = {
	"revsocks".service = {
	  build = {
	    context = "/etc/nixos/revsocks";
#	    target = "prod";
	  };
	  network_mode = "host";
	  command = ["./revsocks" "--connect" "100.71.106.52:8443" "-pass" "Password1234"];
	  restart = "unless-stopped";
	  #ports = ["1055:1055"];  
	#image = "jpillora/chisel";
	  #command = ["client" "0.0.0.0:3060 100.71.106.52:1080/tcp"]; 
	 #Cmd = "echo 'test'";
	};
#	server = {
#	  image = "jpillora/chisel";
#	};
    };
     docker-compose.volumes = {

     };
 #   docker-compose.raw = {
#	"test" = "test";
#	services = {
#	  "chisel" = {
	     #image = "jpillora/chisel";
	     #network_mode = "host";
	 #    command = "chisel client 0.0.0.0:3060:100.71.106.52:1080/tcp";	
#	   };
#	};	
#    };
  };
#};
#};
};
};
};
*/
#.config.arionComposition.config."docker-compose".raw = { 
#docker-compose.raw = {
#services = {
#chisel = {
#image = "jpillora/chisel";
#network_mode = "host";
#command = "chisel client 0.0.0.0:3060:100.71.106.52:1080/tcp";
#};
#};
#project.name = "chisel";
#backend = "docker";
#projects."chisel".settings.services."chisel" = { config }: {
#config
#};
#projects."chisel".settings.services."chisel" = { config }: {
#config.docker-compose.raw = {

#};
#projects = { config }: {
#projects."chisel".settings = { config }: {

#};
#};
#backend = "docker";
#projects = {
##chisel = {
##name = "chisel";
##image = "jpillora/chisel";
##network_mode = "host";
##command = "chisel client 0.0.0.0:3060:100.71.106.52:1080/tcp";
##extended = ["chisel client 0.0.0.0:3060:100.71.106.52:1080/tcp"];
#
##};
##services = {
#
##} 
#
#"chisel".settings.services."chisel".service = {
#image = "jpillora/chisel";
##image.command = [
##"chisel"
##"client"
##"0.0.0.0:3060:100.71.106.52:1080/tcp"
##];
#name = "chisel";
##command = "chisel client 0.0.0.0:3060:100.71.106.52:1080/tcp";
#network_mode = "host";
#};
#};
#};

virtualisation.oci-containers = {
  backend = "docker";
   containers = {
#   pebble-challtestsrv = {
#	image = "letsencrypt/pebble-challtestsrv:latest";
#	ports = ["8055:8055"];
#	cmd = 
   #};    
#    chisel = {
#	image = "jpillora/chisel";
#	extraOptions = ["--net=host"];
#chisel client 0.0.0.0:3060:100.71.106.52:1080/tcp"];
	#ports = ["3060:3060"];
#	cmd = ["client 0.0.0.0:3060:100.71.106.52:1080/tcp"];
#   };
    
    coweire = {};
   # pebble = {
   #   image = "letsencrypt/pebble";
   #   ports = ["14000:14000"	"15000:15000"];  # Expose the Pebble challenge test server port
	
      # Additional configurations for Pebble
   #   environment = {
   #     PEBBLE_VA_NOSLEEP = "1";  # Optional: Disable sleeping in the VA (Validity Authority)
   #     PEBBLE_WFE_NONCEREJECT = "true";  # Optional: Allow nonces to be reused
   #   };
  
     #};
#    headscale = {};
#    coweire.image = "cowrie:latest"
	
    };
};
virtualisation.oci-containers.containers.coweire.image = "cowrie/cowrie:latest";
virtualisation.oci-containers.containers.coweire.ports = ["22:2222"];




#virtualisation.oci-containers.containers.headscale.image = "headscale/headscale:latest";
#virtualisation.oci-containers.containers.headscale.ports = ["7090:8080"];
#virtualisation.oci-containers.containers.headscale.volumes = [
#"./config:/etc/headscale"
#"./data:/var/lib/headscale"
#];
#virtualisation.oci-containers.containers.headscale.cmd = ["headscale serve"];

#virtualisation.oci-containers.containers.coweire.image = "cowrie:latest";
#virtualisation.oci-containers.containers.coweire.name = "cowrie";

hardware.bluetooth.enable = true; # enables support for Bluetooth
hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
hardware.enableAllFirmware = true;
#hardware.gpgSmartcards.enable = true;

#hardware.nvidia.prime = {
#	offload = {
		
		#enable = true;
#		enableOffloadCmd = true;
#	};
	# Make sure to use the correct Bus ID values for your system!#
#	reverseSync.enable = true;
#	sync.enable = true;#
#	intelBusId = "PCI:0:2:0";
#	nvidiaBusId = "PCI:1:0:0";
#};
  nixpkgs.config.nvidia.acceptLicense = true;
  services.xserver.videoDrivers = ["nvidia" "intel"];

 # hardware.opengl = {
 #   enable = true;
 #  # driSupport = true;
 #   driSupport32Bit = true;
 # };

  hardware.nvidia = {
#pkgs-nvidia
  #  package = pkgs-nvidia.nvidia_x11_beta;
    #package = pkgs-nvidia.linuxPackages.nvidiaPackages.beta; 
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    dynamicBoost.enable = true;

    powerManagement = {
      enable = true;
     # finegrained = true;
    };

    prime = {
      intelBusId = "PCI:00:02:0"; 
    #  amdgpuBusId = "PCI:05:00:0";
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
   # SHIVUMDUMBASS.configuration = {
#	boot.extraModulePackages = lib.mkForce [
#	 config.boot.kernelPackages.v4l2loopback.out	
 #	];
 #   };
    GDM.configuration = {
   services = {
    displayManager = {
	execCmd = lib.mkForce "exec ${pkgs.gnome.gdm}/bin/gdm";
     };
     xserver = {
	displayManager = {
#	execCmd = "${pkgs.gnome.gdm}/bin/gdm";
	gdm = {
	#	wayland.enable = true;
	#	execCmd = "${pkgs.gnome.gdm}/bin/gdm";
		enable = true;
		wayland = true;
#		wayland.enable = true;
##	enable = lib.mkForce true;
	};
     };
    };
   };
  };
  DVfio.configuration = {
	environment.extraInit = ''
		#export GSK_RENDERER=gl
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
  # Remove NVIDIA USB xHCI Host Controller devices, if present
  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
  # Remove NVIDIA USB Type-C UCSI devices, if present
  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
  # Remove NVIDIA Audio devices, if present
  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
  # Remove NVIDIA VGA/3D controller devices
  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
'';
boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
  };
};




services.flatpak.enable = true;
services.pcscd.enable = true;
#programs.gpg.scdaemonSettings = {
 # disable-ccid = true;
#};
 #networking.firewall = {
 #   checkReversePath = "loose";
 #   trustedInterfaces = [ "tailscale0" ];
 #   allowedUDPPorts = [ config.services.tailscale.port ];
#  };

networking.firewall = {
  enable = true;
  checkReversePath = "loose";
  trustedInterfaces = [ "tailscale0" "waydroid0" ];
  allowedTCPPorts = [ 3060 22 8384 22000 51820 67 53 ]; # Allow incoming SSH connections
  allowedUDPPorts = [ 22000 21027 51820 67 53 config.services.tailscale.port]; 
# extraCommands = ''
  #  socat TCP-LISTEN:1080,fork SOCKS4A:100.71.106.52:3060,socksport=1080,proxyauth=root:sK4mmi@=
  #'';
};

security.pam.services = {
  sddm.enableKwallet = true;
  login.u2fAuth = true;
 };

services.openssh.ports = [3060];
services.udev.packages = [ pkgs.yubikey-personalization pkgs.libu2f-host ];

 # Enable OpenGL
 #hardware.opengl = {
  #  enable = true;
  #  driSupport = true;
  #  driSupport32Bit = true;
  #};

  # Load   services.xserver.videoDrivers = ["intel" "nvidia"];
#nvidia driver for Xorg and Wayland
  #services.xserver.videoDrivers = ["nvidia"];
#  services.xserver.displayManager.sddm = {
#	wayland.enable = true;
#	settings = {
	
#	};
#  };
 # hardware.nvidia = {

   # Modesetting is required.
 #   modesetting.enable = true;
    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
 #   powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
  #  powerManagement.finegrained = false;
    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
  #  open = false;
    # Enable the Nvidia settings menu,
        # accessible via `nvidia-settings`.
  #  nvidiaSettings = true;
    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    #package = config.boot.kernelPackages.nvidiaPackages.beta;
#    package = config.boot.kernelPackages.nvidiaPackages.stable;
  # };
  # Make some extra kernel modules available to NixOS
  boot.kernelPackages = #[ 
#	pkgs-nvidia.linuxPackages_latest;
	pkgs.linuxPackages_zen;
	#pkgs.linuxPackages_hardened;
#	pkgs.linuxKernel.packages.linux_xanmod_latest;
#	pkgs-nvidia.linuxPackages_6_6; 
#	pkgs.linuxPackages_latest;
#	pkgs.linuxPackages_6_8;
# ];
  boot.extraModulePackages = 
	#with config.boot.kernelPackages;
    [  
	acermodule  
	config.boot.kernelPackages.v4l2loopback.out
    ];

#     boot.postBootCommands = ''
   #   ${concatMapStringsSep
   #     "\n"
   #     (user: let
   #       configDest =
   #         if config.modules.system.disk.eraseOnBoot.enable then
   #           "/persist/var/lib/AccountsService/users/${user.name}"
   #         else
   #           "/var/lib/AccountsService/users/${user.name}";
   #       iconDest =
   #         if config.modules.system.disk.eraseOnBoot.enable then
   #           "/persist/var/lib/AccountsService/icons/${user.name}"
   #         else
   #           "/var/lib/AccountsService/icons/${user.name}";
   #       userConf = ''
   #         [User]
   #         Session=
   #         XSession=
   #         Icon=${iconDest}
   #         SystemAccount=false
   #       ''; in ''
   #       cp -r  ${user.profilePicture} ${iconDest}
   #       echo '${userConf}' > ${configDest}
   #     '')
    #    (builtins.attrValues config.modules.system.users.users)
    #  }
 #   '';

#  boot.postBootCommands = ''
#      ${concatMapStringsSep
#        "\n"
#        (user: let
#          configDest =
#            if config.modules.system.disk.eraseOnBoot.enable then
#              "/persist/var/lib/AccountsService/users/${user.name}"
#            else
#              "/var/lib/AccountsService/users/${user.name}";
#          iconDest =
#            if config.modules.system.disk.eraseOnBoot.enable then
#              "/persist/var/lib/AccountsService/icons/spiderunderurbed"
#            else
#              "/var/lib/AccountsService/icons/spiderunderurbed";
#          userConf = ''
#            [User]
#            Session=
#            XSession=
#            Icon=${iconDest}
#            SystemAccount=false
#          ''; in ''
#          cp  /home/spiderunderurbed/.face.png ${iconDest}/
#          echo '${userConf}' > ${configDest}
#        '')
#        (builtins.attrValues config.modules.system.users.users)
#      }
#    '';

  # Activate kernel modules (choose from built-ins and extra ones)
  boot.kernelModules = [
    # all of these are for the rgb
    "facer" "wmi" "sparse-keymap" "video" 
    # Virtual Camera
    "v4l2loopback"
    # Virtual Microphone, built-in
    "snd-aloop"
  ];
#  boot.initrd.luks = {
  # fido2Support = true; 
  # yubikeySupport = true;
#   devices = {
#     "root" = {#
#	device = "/dev/disk/by-uuid/dd28e1bb-dae0-4794-b8ae-8d52b8bd9189";	
#     };
#     "home" = {#
#	device = "/dev/disk/by-uuid/d7b25073-d690-4163-b3f0-5de410afe535";
 #    };
 #    "root2" = {
#	device = "/dev/disk/by-uuid/629b4fa3-d953-4b25-a219-0552ec6aeb39";
  #   };
 #    "root3" = {
#	device = "/dev/disk/by-uuid/d1a832fe-832f-4ca0-91e4-5e6b026bd013";
  #    };
  # };
  #};
  # Set initial kernel module settings
  boot.extraModprobeConfig = ''
    # exclusive_caps: Skype, Zoom, Teams etc. will only show device when actually streaming
    # card_label: Name of virtual camera, how it'll show up in Skype, Zoom, Teams
    # https://github.com/umlaeute/v4l2loopback
    options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
  '';
#boot.
#boot.kernelModules = ["v4l2loopback"];
#boot.kernelPatches = [
#{
#name = "foo";
#patch = "/etc/nixos/patches/nvidia-gpl.patch";
#}
#];
#services.bluetooth = {
 # enable = true;
  #package = pkgs.bluez; # Optional: Specify a Bluetooth stack package if not using the default.
#};
#programs.ssh.
services.openssh = {
  enable = true;
  # require public key authentication for better security
  settings.PasswordAuthentication = false;
  settings.KbdInteractiveAuthentication = false;
  #settings.PermitRootLogin = "yes";
  #services.openssh.ports 
};

  #programs.gnupg.agent = {
  #  enable = true;
  #  enableSSHSupport = true;
  #  pinentryFlavor = "gnome3";
  #};
  #hardware.gpgSmartcards.enable = true; # for yubikey
  #systemd.packages = [ pkgs.pcsclite ];
  environment.shellInit = ''
    export GPG_TTY="$(tty)"
  '';
#programs.bash = {
    #enable = true;
 #   shellInit = "export NIXPKGS_ALLOW_INSECURE=1"; 
#   bashrcExtra = ''
 #     . ~/oldbashrc
 #   '';
#};
#programs.kdeconnect.enable = true;
 #programs.steam = {
 #  enable = true;
 #  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
 #  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
 #};

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
  hyprland = (hyprlandConfig);
  #hyprland = { inherit (hyprlandConfig); };
  # hyprland = {
  #   enable = true;
  #   package = pkgs.hyprland;
  #   settings = {  
  #   "$terminal" = "konsole";
  #   "$dropterm"="kitty-dropdown";
  #    "exec-once" = [
  #    #  "[workspace special silent] foot -a quake"
  #      #"[workspace special; size 75% 20%;move 12.5% 40] kitty"
  #      (lib.getExe pkgs.waybar)
 #       "${pkgs.blueman}/bin/blueman-applet"
#	"${pkgs.networkmanagerapplet}/bin/nm-applet"#
#	"${pkgs.pasystray}/bin/pasystray"
  #      #[workspace special; size 75% 20%;move 12.5% 40] kitty
  #      "[workspace special; size 75% 20%;move 12.5% 40] kitty --class=kitty-dropdown"
  #    ];
        #[workspace special; size 75% 20%;move 12.5% 40] kitty
      #"$dropterm"="kitty-dropdown"
  #   "windowrule" = [
  #      "workspace 1,$dropterm"
  #      "float,$dropterm"
  #      "size 75% 20%,$dropterm"
  #      "move 12.5% -469,$dropterm"
  #   ];
 #    debug = { 
#	suppress_errors = true;
   #  };
    #bindsym XF86MonBrightnessUp exec swayosd-client --brightness raise
    #bindsym XF86MonBrightnessUp exec swayosd-client --brightness lower
 #    binde = [
#	", XF86MonBrightnessUp, exec, swayosd-client --brightness lower"
#	", XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
#	", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
#	", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
  #   ];
 #    bindle = [#
#	",XF86AudioMute, exec, swayosd --output-volume mute-toggle"
#     ];
#     bind = [
#Super+C = kill window
        #"SUPER+SHIFT+LEFT,movewindow,mon:eDP-1"
        #"SUPER+SHIFT+RIGHT,movewindow,mon:HDMI-A-1"
        
        #"SUPER+tab,v,layoutmsg,preselect r"
        #"SUPER+tab,h,layoutmsg,preselect d"
        #[workspace special; size 75% 20%;move 12.5% 40] kitty
        #"SUPER+alt,k,[workspace special; size 75% 20%;move 12.5% 40] kitty --class=kitty-dropdown"
#	"SUPER+shift,v,exec,code"
#	"SUPER+shift,s,exex,steam"
#	"SUPER+ESCAPE,s,exec,systemctl suspend"#
#	"SUPER+alt,k,exec,konsole"
  #      "SUPER+alt,s,exec,hyprshot -m region --freeze"
  #      "SUPER,grave,exec,bash ~/home-manager/quake.sh"
  #      "SUPER+alt,m,exec,flatpak run im.fluffychat.Fluffychat"
  #      "SUPER+alt,right,movewindow,mon:r"
  #      "SUPER+alt,left,movewindow,mon:l"
  #      "SUPER+alt,V,exec,flatpak run dev.vencord.Vesktop"
  #      "SUPER,K,exec,hyprctl kill"
  #      "SUPER,L,exec,librewolf"
  #      "SUPER+F,1,fullscreen"
  #      "SUPER,F,fullscreen,1"  
  #   ];
  #   extraConfig = (builtins.readFile /etc/nixos/hyprland.conf);
  #   };
  # }; 
  chromium = {
        enable = true;
   #     package = pkgs.brave;
        extensions = [
           "cjpalhdlnbpafiamejdnhcphjbkeiagm" #ublock
           "nngceckbapebfimnlniiiahkandclblb" #bitwarden
           "mnjggcdmjocbbbhaepdhchncahnbgone" #sponsorblock
           "eimadpbcbfnmbkopoojfekhnkhdbieeh" #dark reader
	   "gebbhagfogifgggkldgodflihgfeippi" #return youtube dislike
	   "cimiefiiaegbelhefglklhhakcgmhkai" #plasma intergration
	   "ghbmnnjooekpmoecnnnilnnbdlolhkhi" #google docs offline
	   "kaacflffkmlaiebklgemhmlfbhificko" #imdb torrent search 
#<<<<<<< HEAD
#=======
	   "kbfnbcaeplbcioakkpcpgfkobkghlhen" #grammerly
#>>>>>>> cdcb124 (Initial commit)
       ];
    };
    firefox = {
	enable = true;
	package = pkgs.librewolf;
	#nativeMessagingHosts.packages = [ pkgs.plasma-browser-integration ];
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
#<<<<<<< HEAD
#=======
		"87677a2c52b84ad3a151a4a72f5bd3c4@jetpack" = {
		    install_url = "https://addons.mozilla.org/firefox/downloads/latest/grammarly-1/latest.xpi";
		    installation_mode = "force_installed";
		};
#>>>>>>> cdcb124 (Initial commit)
    	  };
    };
#    chromium = {
#    	enable = true;
#    	package = pkgs.brave;
#    	extensions = [
#    	  { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
#     	  { id = "nngceckbapebfimnlniiiahkandclblb"; }
#     	  { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; }
#     	  { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; }
#       ];
#    };
    gamescope.enable = true;
    anime-game-launcher.enable = true;
    ssh = {
	extraConfig = ''
		PermitLocalCommand=yes
	'';
#	PermitLocalCommand = "yes";
	askPassword = "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";
    };
#programs.ssh.askPassword 
  # nix-ld = {
#	enable = true;
#	libraries = with pkgs; [
#	];
 #   };
    dconf= {
      enable = true;
    #  settings = {
    #  "org/virt-manager/virt-manager/connections" = {
    #    autoconnect = ["qemu:///system"];
    #    uris = ["qemu:///system"];
    #  };
  #   };  
    }; 
# java = {
#	enable = true;
#	package = pkgs.jre8;
 #   };
    git = {
      enable = true;
      package = pkgs.gitFull;
      config.credential.helper = "libsecret";
    };

   # auto-cpufreq.enable = true;
   # auto-cpufreq.settings = {
   # charger = {
   #   governor = "performance";
   #   turbo = "auto";
   # };

   # battery = {
   #   governor = "powersave";
   #   turbo = "auto";
   # };
   # };
    xwayland.enable = true;
#    firefox.nativeMessagingHosts.packages = [ pkgs.plasma5Packages.plasma-browser-integration ];
    proxychains = {
	enable = false;
#	package = [pkgs.proxychains-ng];
    };
    kdeconnect.enable = true;
    bash = {
	shellInit = "export NIXPKGS_ALLOW_INSECURE=1"; 
    };
    steam = {
    #  enable = false;
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
   # sudo.u2fAuth = true;
    u2f.enable = true;
  };
#  services = {
    #pcscd.enable = true;


 #   udev = {
  #    packages = [
    #    pkgs.yubikey-personalization
   #   ];
   # };
  #};
#programs.gnupg.agent = {
#  enable = true;
#  pinentryFlavor = "qt";
#  enableSSHSupport = true;
#};

#programs = {
    # Programs go here
 #   gparted,
#};
#environment.systemPackages = with pkgs; [
    # Packages go here
#];

#  environment.systemPackages = with pkgs; [
  # Other packages...
 # gparted
 # ];

  virtualisation.virtualbox.host.enable = true;
   users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
  imports =
   [ # Include the results of the hardware scan.
#	 <home-manager/nixos>
	#./weston.nix
#	./volatility
	#./vfio.nix
#	./lanzaboote.nix
#	./protonmail-bridge.nix

#	./hyprland.nix
	./hyprland/nixos-module.nix
	aagl.module
      #./sops-nix/modules/sops
        ./hardware-configuration.nix

#	./waydroid-config.nix
#	(import "${this.home-manager}/nixos")
#      ./de.nix	
	#(import "${home-manager}/nixos")
  #    ./modules/sql-build.nix	  
   #import home-manager 
  ];
  #sops.defaultSopsFile = ./secrets/main.yaml;
  #sops.age.sshKeyPaths = [ "/etc/ssh/id_rsa_2" ];
  #sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  #sops.age.generateKey = true;

  # Bootloader.
  boot.kernel.sysctl = { "net.ipv4.tcp_window_scaling" = true; "net.ipv4.conf.all.forwarding" = true; };
  boot.supportedFilesystems = [ "ntfs" ];
 # boot.loader.efi.canTouchEfiVariables = true;
  #boot.loader.grub = {
  # enable = false;
  # device = "/dev/nvme0n1";
  # efiSupport = true;
  # forceInstall = true;
  # #extraGrubInstallArgs = ["--force"];
  # #devices = ["/dev/nvme0n1p3"];
  # useOSProber = true;
  #};
  #boot.loader.systemd-boot = { #
#	enable = true;
#	configurationLimit = 10;
 # };
  boot.loader = {
  systemd-boot = { #
      enable = false;
      configurationLimit = 10;
  };
  efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
  };
  grub = {
     efiSupport = true;
     configurationLimit = 10;
     #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
     device = "nodev";
     useOSProber = true;
  };
  };
   # Enable GRUB boot loader
 # boot.loader.grub.enable = true;

  # Specify the device for GRUB installation
 # boot.loader.grub.device = "/dev/nvme1n1";  # The entire disk, not a partition

  # Enable EFI support if using UEFI
 # boot.loader.grub.efiSupport = true;

  # Set up GRUB for UEFI systems
 # boot.loader.grub.efi.efiSysMountPoint = "/boot/efi";  # Ensure /boot/efi is mounted

  # Set the GRUB version if needed
  #boot.loader.grub.version = 2;

  boot.runSize = "100%";

  # Optional: configure GRUB for better system support
 # boot.loader.grub.useOSProber = true;  # Detect other OSes if needed
  #boot.loader.efi.canTouchEfiVariables = true;
#  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "daspidercave"; # Define your hostname.
 # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
#  networking.wireless.iwd.enable = true;
  #networking.wireless.roaming.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager = {
	enable = true;
  	wifi = {
	 backend = "wpa_supplicant"; 
	 powersave = false;
  	};
  };
  # Set your time zone.
  time.timeZone = "Pacific/Auckland";

  # Select internationalisation properties.
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
#  services.xserver.displayManager.sddm = {
#        wayland.enable = true;
#        settings = {

#        };
#  };

  services.xserver = {
    #wayland.enable = true;
    enable = true;
    displayManager = {
		hiddenUsers = [ "jellyfin" ]; 
		sddm = {
		#settings = {
	 	# HideUsers="jellyfin";
		#}; 
			wayland.enable = true;
			enable = true;
	    	};
	};
#    displayManager.gdm = {
#	wayland = true;
#	enable = true;
#    };
    desktopManager = {
     plasma6.enable = true; 
     gnome.enable = false;
    };
  };
  # Enable the X11 windowing system.
#  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
#  services.xserver.displayManager.sddm.enable = true;
#  services.desktopManager.plasma6.enable = true;

  #displayManager.gdm.enable = true;
 # services.desktopManager.gnome.enable = true;
#  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "nz";
    xkbVariant = "";
  };

  nix = {
    extraOptions = ''
        
	#post-build-hook = /etc/nix/upload-to-cache.sh
    '';
  };
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  #sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

 # zramSwap = {
 #  enable = true;
 #  algorithm = "zstd";
 # };

  environment.extraInit = ''
    export TEST=test
  #  if [ -f /tmp/kwin_drm_devices_flag ]; then
      #export KWIN_DRM_DEVICES=$(${coreutils}/bin/coreutils)
  #  else
  #   unset KWIN_DRM_DEVICES
  #  fi
    #if [ -f /tmp/kwin_drm_devices.sh ]; then
    #  source /tmp/kwin_drm_devices.sh
    #fi
    #export KWIN_DRM_DEVICES=$(${coreutils}/bin/coreutils)
  ''; 
#  environment.variables = {
     #__EGL_VENDOR_LIBRARY_FILENAMES = "${pkgs.libglvnd}/egl_vendor.d/50_mesa.json";
    # KWIN_DRM_DEVICES= builtins.readlink "/dev/dri/by-path/pci-0000:00:02.0-card";
#    KWIN_DRM_DEVICES=igpu;
#  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
 # i18n.defaultLocale = "en_US.UTF-8";
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
    extraGroups = [ 
	"libvirtd"
	"networkmanager"
	"wheel" 
	"docker"
#	"flatpak"
	];
    packages = with pkgs; [
      firefox
      kate
    #  thunderbird
    ];
  };
};
#  nixpkgs.config.packageOverrides = pkgs: {
#    steam = pkgs.steam.override {
#      extraPkgs = pkgs: with pkgs; [
#        xorg.libXcursor
#        xorg.libXi
#        xorg.libXinerama
#        xorg.libXScrnSaver
#        libpng
#        libpulseaudio
#        libvorbis
#        stdenv.cc.cc.lib
#        libkrb5
#        keyutils
#      ];
#    };
#  };
  # Allow unfree packages
   nixpkgs.config.allowUnfree = true;
   nixpkgs.config.permittedInsecurePackages = [
		"electron"
           	"electron-27.3.11"
		"electron-25.9.0"
		"electron-28.3.3"
   ];
   #nixpkgs.config.packageOverrides = pkgs: {
   # nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
   #   inherit pkgs;
   # };
  #};
 # modules = [ arion.nixosModules.arion ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
 # environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
 # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
#   hardware = { 
#     nvidia = { 
#       open = false; 
#       modesetting.enable = true; 
#       prime = { 
#         offload.enable = true; 
#         intelBusId = "PCI:00:02:0"; 
#         nvidiaBusId = "PCI:01:00:0"; 
#       }; 
#     }; 
#     opengl = { 
#       enable = true; 
#       driSupport = true; 
#       driSupport32Bit = true; 
#       extraPackages = with pkgs; [ 
#         intel-media-driver 
#         vaapiIntel 
#         nvidia-vaapi-driver 
#         vaapiVdpau 
#         libvdpau-va-gl 
#       ]; 
#     }; 
#     pulseaudio.support32Bit = true; 
#   }; 
#  # This value determines the NixOS release from which the default
#  # settings for stateful data, like file locations and database versions
#  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  #system.stateVersion = "24.11";
 # hardware.graphics.enable = true;
 # hardware.graphics.enable32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  boot.tmp.useTmpfs = true;
  system = {
	stateVersion = "24.11"; # Did you read the comment?
        activationScripts = { 
	stdio = lib.mkForce {
        text = ''	
#	source /etc/nixos/venv/bin/activ
	echo "Ran sucessfully"
	#export KWIN_DRM_DEVICES=$(realpath /dev/dri/by-path/pci-0000:00:02.0-card)
	${arion}/bin/arion 
	${startup}/bin/startup	
        '';
	};
  };
};
}
