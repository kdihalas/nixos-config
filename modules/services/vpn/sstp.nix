{ pkgs, ... }:

{
    environment.systemPackages = [
      sstp
      networkmanager-sstp
    ];
}