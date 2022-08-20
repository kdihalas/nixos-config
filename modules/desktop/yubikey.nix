{ pkgs, user, ... }:

{
    services.udev.packages = [ pkgs.yubikey-personalization ];
    environment.shellInit = ''
      export GPG_TTY="$(tty)"
      gpg-connect-agent updatestartuptty /bye
      export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
    '';

    environment.systemPackages = [
      pkgs.pinentry-curses
    ];

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryFlavor = "curses";
    };
}