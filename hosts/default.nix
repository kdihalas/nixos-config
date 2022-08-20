{ lib, inputs, nixpkgs, home-manager, nur, user, location, protocol, ... }:

let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
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
        specialArgs = { inherit inputs user location protocol; }; 
        # Modules that are used.
        modules = [                                             
            nur.nixosModules.nur
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

    # RPI4 profile
    rpi4 = lib.nixosSystem {                               
        system = "aarch64-linux";
        # Pass flake variable
        specialArgs = { inherit inputs user location protocol; }; 
        # Modules that are used.
        modules = [                                             
            nur.nixosModules.nur
            ./rpi4
            ./configuration.nix

            # Home-Manager module that is used.
            home-manager.nixosModules.home-manager {              
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = { inherit user protocol; };  # Pass flake variable
                home-manager.users.${user} = {
                    imports = [(import ./home.nix)] ++ [(import ./rpi4/home.nix)];
                };
            }
        ];
    }; 
}