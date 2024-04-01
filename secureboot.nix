{pkgs, lib, ...}:
let 
lanzaboote = (builtins.getFlake "github:nix-community/lanzaboote/v0.3.0");
in
{
  imports = [
    lanzaboote.nixosModules.lanzaboote
  ];

  environment.systemPackages = with pkgs; [
    sbctl
    tpm2-tss
  ];

  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };

  boot.initrd.systemd = {
    enable = true;
    enableTpm2 = true;
  };
  
  security.tpm2.enable = true;

  boot.initrd.kernelModules = ["tpm_crb"];
}