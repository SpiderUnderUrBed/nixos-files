{ pkgs, lib, config }:
{
  boot.tmp = {
        cleanOnBoot = true; 
        useTmpfs = false;
        tmpfsSize = "75%";
  };
}
