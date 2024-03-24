{pkgs, lib, ...}: 
{
  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    yuzu
    sunshine
  ];
  networking.firewall = {
    allowedTCPPortRanges = [
      { from = 47984; to = 48010; }
    ];
    allowedUDPPortRanges = [
      { from = 47998; to = 48001; }
    ];
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
}
