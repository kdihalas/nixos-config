{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation {
  name = "kubectl";
  src = pkgs.fetchurl {
    url = "https://dl.k8s.io/release/v1.25.0/bin/linux/amd64/kubectl";
    sha256 = "119q430fvdw6d13wljakbfn3cjhrk6agndpfv0i5rj8q484wfg72";
  };
  phases = ["installPhase" "patchPhase"];
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/kubectl
    chmod +x $out/bin/kubectl
  '';
}