{
  description = "My Personal NixOS System Flake Configuration";

  # All flake references used to build my NixOS setup. These are dependencies.   
  inputs = {

    # Nix packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";

    # Unstable Packages
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # User Package Management
    home-manager = {
      url = github:nix-community/home-manager/release-22.11;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NUR packages
    nur = {
      url = "github:nix-community/NUR";                                   
    };
  };

  outputs = inputs @ { self, nixpkgs, unstable, home-manager, nur, ... }:
    let
      user = "kostas";
      location = "$HOME/.setup";
      protocol = "X";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      upkgs = import unstable {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = (
        import ./hosts {
          inherit (pkgs upkgs) lib;
          inherit inputs nixpkgs unstable home-manager nur user location protocol;
        }
      );
    };
}