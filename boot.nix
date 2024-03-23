{pkgs, ...}: 
{
    # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.avahi = {
  enable = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };
}