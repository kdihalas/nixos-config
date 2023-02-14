{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      flatpak
      brave
    ];
    stateVersion = "22.11";
  };

  services = {
    blueman-applet.enable = true;
  };

  programs= {
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [ "git" "sudo" ];
      };
      initExtra = ''
        export PATH="''${PATH}:''${HOME}/.krew/bin"
        export GPG_TTY="$(tty)"
        gpg-connect-agent updatestartuptty /bye > /dev/null
        export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
        eval "$(direnv hook zsh)"
      '';
    };
    git = {
      enable = true;
      userName = "kdihalas";
      userEmail = "kdihalas@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
    home-manager.enable = true;
  };
}