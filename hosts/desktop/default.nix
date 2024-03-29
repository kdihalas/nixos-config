{ pkgs, upkgs, lib, user, lanzaboote, ... }:

{
  imports =
    [(import ./hardware-configuration.nix)]++
    [(import ../../modules/virtualisation/docker.nix)]++
    [(import ../../modules/virtualisation/libvirt.nix)]++
    [(import ../../modules/services/vpn/sstp.nix)]++
    (import ../../modules/desktop);

  environment = {
    systemPackages = with pkgs; [
      yubioath-desktop
      gnome.gnome-tweaks 
      gnome.gnome-boxes
      gnomeExtensions.appindicator
      gnomeExtensions.espresso
      gnomeExtensions.cloudflare-warp-quick-settings
      kubectl
      krew
      nyancat
      docker-compose
      direnv
      gh
      cloudflare-warp
      sbctl
      niv
      upkgs.consul
      upkgs.vault
      upkgs.nomad
      upkgs.nomad-pack
      upkgs.terraform
      upkgs.packer
      upkgs.sapling
    ];

    gnome.excludePackages = (with pkgs; [
      gnome-tour
    ]) ++ (with pkgs.gnome; [
      gnome-music
      gnome-terminal
      evince
      geary
      gnome-contacts
      gnome-characters
    ]); 
  };

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
  };

  systemd.services.warp = {
    enable = true;
    unitConfig = {
      Type = "simple";
    };
    serviceConfig = {
      ExecStart = "${pkgs.cloudflare-warp}/bin/warp-svc";
    };
    wantedBy = ["multi-user.target"];
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  services = {
    xserver= {
      enable = true;
      layout = "gb";
      videoDrivers = [ "amdgpu" ];
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    blueman = {
      enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    packagekit.enable = true;
    flatpak.enable = true;
    gnome.gnome-keyring.enable = true;
    printing = {
      enable = true;
      drivers = [ pkgs.hplipWithPlugin ];
    };
    avahi = {
      enable = true;
      nssmdns = true;
    };
    # pcscd.enable = true;
    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };
}
