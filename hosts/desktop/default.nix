{ pkgs, lib, user, ... }:

{
  imports =
    [(import ./hardware-configuration.nix)]++
    (import ../../modules/desktop);

  environment = {
    systemPackages = with pkgs; [
      yubioath-desktop
      gnome.gnome-tweaks 
      gnomeExtensions.appindicator
    ];

    gnome.excludePackages = (with pkgs; [
      gnome-tour
    ]) ++ (with pkgs.gnome; [
      gnome-music
      gnome-terminal
      evince
      geary
      gnome-contacts
      gnome-characters
    ]); 
  };

  boot = {
    plymouth.enable = true;
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        devices = ["nodev"];
        efiSupport = true;
        enable = true;
        version = 2;
        useOSProber = true;
      };
    };
  };

  services = {
    xserver= {
      enable = true;
      layout = "gb";
      videoDrivers = [ "amdgpu" ];
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    packagekit.enable = true;
    flatpak.enable = true;
    gnome.gnome-keyring.enable = true;
    printing = {
      enable = true;
      drivers = [ pkgs.hplipWithPlugin ];
    };
    avahi = {
      enable = true;
      nssmdns = true;
    };
    # pcscd.enable = true;
    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };
}