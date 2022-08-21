# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, user, location, ... }:

{

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "lp" "scanner" ];
    shell = pkgs.zsh;
    useDefaultShell = false;
  };

  security.sudo.wheelNeedsPassword = false;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_GB.UTF-8";
  };

  security.rtkit.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    pciutils
    usbutils
    killall
    wget
    dig
  ];

  environment.shells = with pkgs; [ bashInteractive zsh ];

  system = {
    stateVersion = "22.05";
  };

  nix = {
    settings ={
      auto-optimise-store = true;           # Optimise syslinks
    };
    gc = {                                  # Automatic garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };

  nixpkgs.config.allowUnfree = true;

}