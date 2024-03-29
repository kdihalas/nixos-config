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
    vscode = {
      enable = true;
      package = pkgs.vscode;
      extensions = with pkgs.vscode-extensions; [
          ms-vscode.cpptools
      ];
    };
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
        commit.gpgsign = true;
        user.signingkey = "C71B7C312DDFBF9D";
        init.defaultBranch = "main";
      };
    };
    tmux = {
      enable = true;
    };
    home-manager.enable = true;
  };
}