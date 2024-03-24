interface: {pkgs,...}:
{
  networking.interfaces."${interface}".wakeOnLan = {
    enable = true;
    policy = [ "magic" ];
  };
  # systemd.services.wakeonlan = {
  # description = "Reenable wake on lan every boot";
  # after = [ "network.target" ];
  # serviceConfig = {
  #     Type = "simple";
  #     RemainAfterExit = "true";
  #     ExecStart = "${pkgs.ethtool}/sbin/ethtool -s enp4s0 wol g";
  #   };
  #   wantedBy = [ "default.target" ];
  # };
  # environment.systemPackages = with pkgs; [
  #   ethtool
  # ];
}