{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      flatpak
      steam
      bottles
    ];
  };

  services = {
    blueman-applet.enable = true;
  };

  programs= {
    vscode = {
      enable = true;
    };
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [ "git" "sudo" ];
      };
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