{
  description = "Kubectl CLI";

  inputs = {
    # Nix packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
  };

  outputs = {self, nixpkgs}: {
    defaultPackage.x86_64-linux =
      with import nixpkgs { system = "x86_64-linux"; };

      stdenv.mkDerivation rec {
        name = "kubectl-${version}";
        version = "1.25.0";

        # I still lack stuff here!
      };

      src = fetchurl {
        url = "https://dl.k8s.io/release/v${version}/bin/linux/amd64/kubectl";
        sha256 = "119q430fvdw6d13wljakbfn3cjhrk6agndpfv0i5rj8q484wfg72";
      };

      phases = ["installPhase" "patchPhase"];
      installPhase = ''
        mkdir -p $out/bin
        cp $src $out/bin/kubectl
        chmod +x $out/bin/kubectl
      '';

      meta = with lib; {
        platforms = platforms.linux;
      };
  };
}