{pkgs, lib, config, ...}:
with lib;
let
  sunshineService = config.services.sunshine;
in
{
  options.services.sunshine = {
    enable = mkEnableOption "sunshine";

    package = mkPackageOption pkgs "sunshine" { };
  };

  config = mkIf sunshineService.enable {

    systemd.user.services = {
      sunshine = {
        Unit = {
          Description = "Sunshine is a Game stream host for Moonlight.";
          StartLimitIntervalSec=500;
          StartLimitBurst=5;
        };
        Service = {
          ExecStart = "/${pkgs.sunshine}/bin/sunshine";
          Restart = "on-failure";
          RestartSec = "5s";
        };
        Install.WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}