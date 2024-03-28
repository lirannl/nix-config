{pkgs, lib, ...}: 
{
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
  hardware.opengl = {
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd 
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  

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
  security.wrappers.sunshine = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+p";
    source = "${pkgs.sunshine}/bin/sunshine";
  };
  services.udev.extraRules = ''
  KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
  '';
}
