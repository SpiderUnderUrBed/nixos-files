# nbfc.nix 
{ 
  config, 
  inputs, 
  pkgs, 
  ... 
}: let 
  myUser = "spiderunderurbed"; #adjust this to your username (unused now, settings file lives in the store)

  # if you are on stable uncomment the next line 
  # nbfcBase = inputs.nbfc-linux.packages.x86_64-linux.default;
  # if you are on unstable uncomment the next line 
  nbfcBase = pkgs.nbfc-linux;

  # nbfc-linux with the Acer Predator PH315-55 profile added to its configs dir
  nbfc = nbfcBase.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      mkdir -p $out/share/nbfc/configs
      cp ${./nbfc-configs/Acer-Predator-PH315-55.json} \
         $out/share/nbfc/configs/Acer-Predator-PH315-55.json
    '';
  });

  # service settings file, replaces the empty ~/.config/nbfc.json
  nbfcSettings = pkgs.writeText "nbfc.json" ''
    {"SelectedConfigId": "Acer-Predator-PH315-55"}
  '';

  command = "bin/nbfc_service --config-file '${nbfcSettings}'"; 
in { 
  environment.systemPackages = [ 
    # if you are on stable uncomment the next line 
    # inputs.nbfc-linux.packages.x86_64-linux.default 
    # if you are on unstable uncomment the next line 
    nbfc
  ]; 

  # EC access with write support (needed for fan control on most laptops)
  boot.kernelModules = [ "ec_sys" ];
  boot.extraModprobeConfig = "options ec_sys write_support=1";

  systemd.services.nbfc_service = { 
    enable = true; 
    description = "NoteBook FanControl service"; 
    serviceConfig.Type = "simple"; 
    path = [pkgs.kmod]; 
 
    # if you are on stable uncomment the next line 
    #  script = "${inputs.nbfc-linux.packages.x86_64-linux.default}/${command}"; 
    # if you are on unstable uncomment the next line 
    script = "${nbfc}/${command}"; 
    
    wantedBy = ["multi-user.target"]; 
  }; 
}
