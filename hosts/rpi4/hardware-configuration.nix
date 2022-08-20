{ config, pkgs, lib, unzip, fetchurl, ... }:

{
  imports = 
  [
    "${fetchTarball "https://github.com/NixOS/nixos-hardware/archive/936e4649098d6a5e0762058cb7687be1b2d90550.tar.gz" }/raspberry-pi/4"
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  networking = {
    useDHCP = lib.mkDefault true;
    hostName = "rpi4-nixos"; # Define your hostname.
    firewall.enable = false;
  };

  # Enable GPU acceleration
  hardware.raspberry-pi."4".fkms-3d.enable = true;
}
