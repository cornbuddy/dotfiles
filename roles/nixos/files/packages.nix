# here live installed packages and their configurations

{ config, pkgs, ... }:

let
  unstable = import
    (fetchTarball "https://github.com/nixos/nixpkgs/tarball/nixos-unstable")
    { config = config.nixpkgs.config; };
in
{
  nixpkgs.config.allowUnfree = true;

  programs.niri.enable = true;
  programs.fish.enable = true;
  environment.systemPackages = with unstable; [
    tuigreet
    alacritty
    firefox
    telegram-desktop
    pavucontrol
  ];

  security.sudo-rs = {
    enable = true;
    wheelNeedsPassword = false;
    execWheelOnly = true;
  };
  security.polkit.enable = true;
  security.pam.services.swaylock = {};

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  services.openssh.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.xserver = {
    enable = true;
    xkb.options = "ctrl:swapcaps";
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --remember --remember-user-session --time --cmd niri-session";
	      user = "greeter";
      };
    };
  };
  # hide kernel messages to print nice tui
  boot.kernelParams = [ "quiet" "loglevel=3" ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
}
