{
  project.name = "full-nixos";
  services.webserver = { pkgs, lib, ... }: {
    nixos.useSystemd = true;
    nixos.configuration.boot.tmpOnTmpfs = true;
    nixos.configuration.networking.useDHCP = false;
    nixos.configuration.services.nginx.enable = true;
    nixos.configuration.services.nginx.virtualHosts.localhost.root = "${pkgs.nix.doc}/share/doc/nix/manual";
    nixos.configuration.services.nscd.enable = false;
    nixos.configuration.system.nssModules = lib.mkForce [];
    nixos.configuration.systemd.services.nginx.serviceConfig.AmbientCapabilities = 
      lib.mkForce [ "CAP_NET_BIND_SERVICE" ];
    service.useHostStore = true;
    service.ports = [
      "8000:80" # host:container
    ];
  };
}

#{
#  project.name = "revsocks";

#  services.revsocks = { pkgs, ... }:
#    let
#      revsocksDir = "/app/revsocks";
#    in {
#      service.useHostStore = true;
#      service.command = ''
#        mkdir -p ${revsocksDir}
#        git clone https://github.com/kost/revsocks.git ${revsocksDir}
#        cd ${revsocksDir}
#        make
#        ./revsocks --connect 100.71.106.52:8443 -pass Password1234
#      '';
#    };
#}#

#{ pkgs, ... }:

#{
 # networking.firewall.allowedTCPPorts = [ 80 443 ];  # Adjust as needed#
#
  #services.docker.enable = true;

  #services.docker.extraConfig = ''
    # Enable iptables forwarding
   # iptables -P FORWARD ACCEPT
   # iptables -A FORWARD -i wlan0 -o docker0 -j ACCEPT
   # iptables -A FORWARD -i docker0 -o wlan0 -j ACCEPT
  #'';
  #services.revsocks = {
  #  service.useHostStore = true;
  #  service.network_mode = "host";
  #  service.build.context = "./revsocks";
   # Add more configurations as needed
  #};
#}

#{ pkgs, ... }: {
#  config.services = {
#   revsocks = let  builtins.toFile "revsocks.json" (builtins.toJSON {

 # }; in
#{
#service.useHostStore = true;
#service.command = ["./revsocks" "--connect" "100.71.106.52:8443" "-pass" "Password1234"];   
#service.network_mode = "host";
#system.build.context = "./revsocks";
##};
#  };
#}
#{
#  project.name = "revsocks";
#  services.revsocks = { pkgs, lib, ... }: {
#    nixos.useSystemd = true;
  #  nixos.configuration.boot.tmpOnTmpfs = true;
  #  nixos.configuration.networking.useDHCP = false;
  #  nixos.configuration.services.nginx.enable = true;
  #  nixos.configuration.services.nginx.virtualHosts.localhost.root = "${pkgs.nix.doc}/share/doc/nix/manual";
   # nixos.configuration.services.nscd.enable = false;
  #  nixos.configuration.system.nssModules = lib.mkForce [];
   # nixos.configuration.systemd.services.nginx.serviceConfig.AmbientCapabilities = 
    #  lib.mkForce [ "CAP_NET_BIND_SERVICE" ];
#    service.useHostStore = true;
#    service.network_mode = "host";
#    service.build.context = "./revsocks";
	 #service.ports = [
    #  "8000:80" # host:container
    #];
#  };
#}
