{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./nvidia-disable.nix
      ./packages.nix
    ];

  system.stateVersion = "26.05";

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
