{ config, lib, pkgs, user, ... }:

{
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };

  programs= {
    htop = {
      enable = true;
    };
    home-manager.enable = true;
  };
}
