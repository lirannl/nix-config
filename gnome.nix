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
  ];

  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverrides = ''
        [org.gnome.desktop.screensaver]
        lock-enabled=false
        [org/gnome/desktop/interface]
        color-scheme = "prefer-dark";
        [org/gnome/shell]
        enabled-extensions=['gsconnect@andyholmes.github.io'];
      '';
    };
  };
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }
    ];
  };
}