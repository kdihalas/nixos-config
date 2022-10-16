{ pkgs, ... }:

{
    environment.systemPackages = [
      pkgs.sstp
      pkgs.networkmanager-sstp
    ];
}