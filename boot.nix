#{ pkgs lib config }:
{ pkgs, lib, config, ... }:
{
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
     enable = false;
     efiSupport = true;
     configurationLimit = 10;
     #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
     device = "nodev";
     useOSProber = true;
  };
  };
}
