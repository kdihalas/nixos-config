{ pkgs, ...}:

{

  system.activationScripts.makeSabnzbdDir =
  ''
    mkdir -p /home/media/dnsserver/config
    chown media:media /home/media/dnsserver/config
  '';

  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      sabnzbd = {
        image = "roxedus/ts-dnsserver:latest";
        environment = {
          PUID = "1000";
          PGID = "1000";
          TZ = "Europe/London";
        };
        ports = [
          "53:53/udp"
          "5380:5380"
        ];
        volumes = [
          "/home/media/dnsserver/config:/config"
        ];
        autoStart = true;
      };
    };
  };
}