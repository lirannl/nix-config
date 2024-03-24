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
        Unit.Description = "Sunshine is a Game stream host for Moonlight.";
        Service.ExecStart = "${sunshineService.package}/bin/sunshine";
        Install.WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}