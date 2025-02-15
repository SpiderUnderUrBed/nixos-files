{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.services.expressvpn = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable the ExpressVPN daemon.
      '';
    };

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.expressvpn;
      description = ''
        The package to use for ExpressVPN.
      '';
    };
  };

  config = lib.mkIf config.services.expressvpn.enable {
    boot.kernelModules = [ "tun" ];

    systemd.services.expressvpn = {
      description = "ExpressVPN Daemon";
      serviceConfig = {
        ExecStart = "${config.services.expressvpn.package}/bin/expressvpnd";
        Restart = "on-failure";
        RestartSec = 5;
      };
      wantedBy = [ "multi-user.target" ];
      wants = [ "network-online.target" ];
      after = [
        "network.target"
        "network-online.target"
      ];
    };
  };

  meta.maintainers = with lib.maintainers; [ yureien ];
}
