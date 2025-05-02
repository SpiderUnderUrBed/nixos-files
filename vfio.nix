{ pkgs, lib, ... }:
let 
  #script = pkgs.writeScriptBin "KWIN_DRM_DEVICES.sh" ''
  #      realpath /dev/dri/by-path/pci-0000\:00\:02.0-card
  #'';
#  tmpfilePath = "${builtins.getHome}/.config/plasma-workspace/env/export-vars";

#  moveScript = ''
#    mv $out/bin/KWIN_DRM_DEVICES.sh ${tmpfilePath}
#  '';
  coreutils = pkgs.writeShellApplication {
     name = "coreutils";
     runtimeInputs = [
        pkgs.coreutils
     ];
     text = ''
        realpath /dev/dri/by-path/pci-0000:00:02.0-card 
     '';
  };

in
{
  boot = {
    kernelParams = [
#      "module_blacklist=i915"
#      "NVreg_EnableGpuFirmware=0"
      "iommu=pt"
      "intel_iommu=on"
      "vfio_iommu_type1.allow_unsafe_interrupts=1"
      "kvm.ignore_msrs=1"
#      "initcall_blacklist=simpledrm_platform_driver_init"
#      "nvidia_drm.fbdev=1"
    ];
  };
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
#         package = pkgs.qemu_kvm.overrideAttrs (old: {
#          patches = old.patches ++ [
#                (builtins.toFile "qemu.diff" (builtins.readFile ./qemu-8.2.0.patch))
##              (builtins.readFile /etc/nixos/qemu-8.2.0.patch)
#          ];
##        });
        runAsRoot = true;
        ovmf.enable = true;
        verbatimConfig = ''
          user = "spiderunderurbed"
          group = "users"
          namespaces = []
        '';
      };
    };
  };
  environment = {
    systemPackages = [ pkgs.dmidecode ];
    shellAliases = {
      vm-start = "virsh start win11";
      vm-stop = "virsh shutdown win11";
    };
  };

  programs.virt-manager.enable = true;

  virtualisation.libvirtd.hooks.qemu = {
    "AAA" = lib.getExe (
      pkgs.writeShellApplication {
        name = "qemu-hook";

        runtimeInputs = [
          pkgs.libvirt
          pkgs.systemd
          pkgs.kmod
        ];

        text = ''
          GUEST_NAME="$1"
          OPERATION="$2"

#         echo "$1"
#         echo "$2"

          if [ "$GUEST_NAME" != "win11" ]; then
            exit 0
          fi

          VFIO_FLAG="/tmp/enable-vfio-switch"
  	  if [ ! -f "$VFIO_FLAG" ]; then
    	    echo "VFIO flag not found, skipping GPU passthrough steps."
    	    exit 0
  	  fi

          if [ "$OPERATION" == "prepare" ]; then
              #systemctl stop sddm.service
              systemctl stop display-manager.service
#             systemctl set-environment KWIN_DRM_DEVICES=${coreutils}
              echo true > /tmp/kwin_drm_devices_flag      
              modprobe -r -a nvidia_uvm nvidia_drm nvidia nvidia_modeset
              virsh nodedev-detach pci_0000_01_00_0
              virsh nodedev-detach pci_0000_01_00_1
              #fix me
              #systemctl set-property --runtime -- user.slice AllowedCPUs=8-15,24-31
              #systemctl set-property --runtime -- system.slice AllowedCPUs=8-15,24-31
              #systemctl set-property --runtime -- init.scope AllowedCPUs=8-15,24-31
              systemctl start display-manager.service

              virsh net-start default
          fi

          if [ "$OPERATION" == "release" ]; then
            #systemctl stop sddm.service
            systemctl stop display-manager.service
            #fix me
            #systemctl set-property --runtime -- user.slice AllowedCPUs=0-31
            #systemctl set-property --runtime -- system.slice AllowedCPUs=0-31
            #systemctl set-property --runtime -- init.scope AllowedCPUs=0-31
            virsh nodedev-reattach pci_0000_01_00_0
            virsh nodedev-reattach pci_0000_01_00_1
            modprobe -a nvidia_uvm nvidia_drm nvidia nvidia_modeset
           # systemctl start sddm.service
            systemctl start display-manager.service
          fi

        '';
      }
    );
  };
  
  systemd.user.tmpfiles.users.spiderunderurbed.rules = [
   # "L+ %h/.config/plasma-workspace/env/ - - - - ${script}"
  ];
  systemd.tmpfiles.rules = [
  "f /dev/shm/looking-glass 0660 spiderunderurbed qemu-libvirtd -"
  ];
}
