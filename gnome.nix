{pkgs, ...}:
{
  # Dependencies
  imports = [
    ./gui.nix
    ./boot.nix
  ];

  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    gnomeExtensions.gsconnect
    gnome.dconf-editor
  ];

  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome = {
      enable = true;
    };
  };
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
      { from = 3389; to = 3389 ;}
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }
    ];
  };
}