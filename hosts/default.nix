{ lib, inputs, nixpkgs, unstable, home-manager, nur, user, location, protocol, lanzaboote, ... }:

let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
        inherit system;
        # Allow proprietary software
        config.allowUnfree = true;
    };

    upkgs = import unstable {
        inherit system;
        # Allow proprietary software
        config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
in
{
    # Desktop profile
    desktop = lib.nixosSystem {                               
        inherit system;
        # Pass flake variable
        specialArgs = { inherit inputs upkgs user location protocol; }; 

        # Modules that are used.
        modules = [                                             
            nur.nixosModules.nur
            # lanzaboote.nixosModules.lanzaboote
            ./desktop
            ./configuration.nix

            # Home-Manager module that is used.
            home-manager.nixosModules.home-manager {              
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = { inherit user protocol; };  # Pass flake variable
                home-manager.users.${user} = {
                    imports = [(import ./home.nix)] ++ [(import ./desktop/home.nix)];
                };
            }
        ];
    };  
}