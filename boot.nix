#{ pkgs lib config }:
{ pkgs, lib, config, ... }:
{
          #boot.loader.systemd-boot.enable = pkgs.lib.mkForce false;
 
  boot = {
  lanzaboote = {
     enable = false;
     #enable = true;
     pkiBundle = "/etc/secureboot";
  }; 
  loader = {
  systemd-boot = { #
#      enable = lib.mkForce true;
      enable = true;
      configurationLimit = 10;
  };
  efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot"; # ← use the same mount point here.
  };
  grub = {
     enable = false;
     efiSupport = true;
     configurationLimit = 10;
     #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
     device = "nodev";
     useOSProber = true;
  };
  };
  };
}
