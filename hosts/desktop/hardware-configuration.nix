# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    initrd = {
      availableKernelModules = [ "nvme" "ahci" "xhci_pci" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ "amdgpu" ];
      verbose = false;
    };
    kernelModules = [ "kvm-amd" ];
    consoleLogLevel = 0;
    kernelParams = ["quiet" "udev.log_level=3" ];
    extraModulePackages = [ ];
  };

  fileSystems."/" =
    { device = "/dev/disk/by-label/NIXOS_ROOT";
      fsType = "ext4";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-label/NIXOS_HOME";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/NIXOS_BOOT";
      fsType = "vfat";
    };

  swapDevices = [ ];

  networking = {
    useDHCP = lib.mkDefault true;
    hostName = "kostas-nixos"; # Define your hostname.
    firewall.enable = false;
  };
  # networking.interfaces.enp39s0.useDHCP = lib.mkDefault true;

  # GPU hardware acceleration
  hardware = {
    opengl = {
      driSupport = true;
      driSupport32Bit = true;	
      extraPackages = with pkgs; [
        amdvlk
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    video.hidpi.enable = lib.mkDefault true;
    pulseaudio.enable = false;
  };
}
