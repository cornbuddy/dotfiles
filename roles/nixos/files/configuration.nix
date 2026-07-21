{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./nvidia-disable.nix
      ./packages.nix
    ];

  system.stateVersion = "26.05";

  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    colors = [
      "3b4252" # Color  0: Polar Night (Black)
      "bf616a" # Color  1: Aurora (Red)
      "a3be8c" # Color  2: Aurora (Green)
      "ebcb8b" # Color  3: Aurora (Yellow)
      "81a1c1" # Color  4: Frost (Blue)
      "b48ead" # Color  5: Aurora (Purple)
      "88c0d0" # Color  6: Frost (Cyan)
      "e5e9f0" # Color  7: Snow Storm (White)
      "4c566a" # Color  8: Polar Night (Bright Black)
      "bf616a" # Color  9: Aurora (Bright Red)
      "a3be8c" # Color 10: Aurora (Bright Green)
      "ebcb8b" # Color 11: Aurora (Bright Yellow)
      "81a1c1" # Color 12: Frost (Bright Blue)
      "b48ead" # Color 13: Aurora (Bright Purple)
      "8fbcbb" # Color 14: Frost (Bright Cyan)
      "eceff4" # Color 15: Snow Storm (Bright White)
    ];
  };

  hardware.enableAllFirmware  = true;
  security.rtkit.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 3d";

  networking.firewall.enable = false;
  networking.hostName = "workstation";
  networking.networkmanager.enable = true;
  networking.networkmanager.insertNameservers = [ "1.1.1.1" "1.0.0.1" ];

  time.timeZone = "Europe/Minsk";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  services.logind.lidSwitch = "lock";
  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
  };

  users.users.cornbuddy = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "cornbuddy";
    extraGroups = [ "networkmanager" "wheel" "input" "docker" "audio" ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;
}
