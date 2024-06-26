# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, config, ... }:
let 
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  unstableTarball =
    fetchTarball
      "https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz";
  logi_keyboard_fn = (builtins.getFlake "github:lirannl/logi_keyboard_fn/055dcdb592825055130242c155d981842886c467")."${builtins.currentSystem}";
in
{
  imports = [
    ./local.nix
    ./local_modules.nix
    (import "${home-manager}/nixos")
    # logi_keyboard_fn.nixosModules
  ];

  # Set your time zone.
  time.timeZone = "Australia/Brisbane";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  documentation.nixos.enable = false;
  services.printing.enable = false;

  services.avahi = {
    publish = {
      userServices = true;
      enable = true;
    };
    openFirewall = true;
    ipv4 = true;
    ipv6 = true;
  };

  services.zerotierone = {
    enable = true;
    joinNetworks = [ "856127940cacf0c1" ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.liran = {
    isNormalUser = true;
    description = "Liran Piade";
    shell = pkgs.nushell;
    extraGroups = [ "networkmanager" "wheel" "adbusers" "liran" ];
  };
  home-manager.users.liran = import ./liran_home.nix;

  # Allow unfree packages
  nixpkgs.config =
  {
    allowUnfree = true;
    packageOverrides = pkgs: {
      nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };
  programs.adb.enable = true;
  services.resolved = {
    enable = true;
  };
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    rustup
    git
    gcc
    nushell
    neovim
    libva
    nil
    xorg.xeyes
    wl-clipboard
    spotify
    logi_keyboard_fn.packages.default
  ];

  hardware.opengl.driSupport32Bit = true;

  environment.gnome.excludePackages = with pkgs.gnome; [pkgs.gnome-tour simple-scan gnome-contacts gnome-maps yelp gnome-font-viewer];
  environment.variables.EDITOR = "nvim";

  services.udev.extraRules = "ACTION==\"add\", KERNEL==\"hidraw[0-9]*\", RUN+=\"${logi_keyboard_fn.packages.default}/bin/fn_activator\"";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
