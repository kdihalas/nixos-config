{pkgs, ...}:

{
  virtualisation = {
    libvirtd = {
      enable = true;
    };
  };
  boot.extraModprobeConfig = "options kvm_amd nested=1";
  users.extraGroups = {
    libvirtd.members = [ "kostas" ];
    qemu-libvirtd.members = ["kostas"];
  };
}