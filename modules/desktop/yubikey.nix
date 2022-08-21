{ pkgs, user, ... }:

{
    services.udev.packages = [ pkgs.yubikey-personalization ];

    environment.systemPackages = [
      pkgs.pinentry-curses
    ];

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryFlavor = "curses";
    };
}