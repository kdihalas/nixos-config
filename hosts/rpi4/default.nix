{ pkgs, lib, user, ... }:

{
  imports = 
    [(import ./hardware-configuration.nix)]++
    [(import ../../modules/virtualisation/podman.nix)]++
    [(import ../../modules/services/podman/media/sabnzbd.nix)];

    services.openssh.enable = true;

    users.groups = {
      media = {
        gid = 1000;
      };
    };

    users.users = {
      media = {
        uid = 1000;
        group = "media";
        isNormalUser = true;
        home = "/home/media";
      };
    };
}