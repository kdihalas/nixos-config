{pkgs, ...}:

{
  virtualisation = {
    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
      };
    };
  };
  users.extraGroups.vboxusers.members = [ "kostas" ];
}