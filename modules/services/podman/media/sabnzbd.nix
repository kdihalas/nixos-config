{ pkgs, ...}:

{

  system.activationScripts.makeSabnzbdDir =
  ''
    mkdir -p /home/media/sabnzbd/config
    chown media:media /home/media/sabnzbd/config
  '';

  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      sabnzbd = {
        image = "lscr.io/linuxserver/sabnzbd:latest";
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/London";
        };
        ports = [
          "8080:8080"
        ];
        volumes = [
          "/home/media/sabnzbd/config:/config"
        ];
        autoStart = true;
      };
    };
  };
}