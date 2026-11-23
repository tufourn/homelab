{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    disko,
    nixos-facter-modules,
    ...
  }: let
    lib' = import ./lib {inherit self inputs nixpkgs;};
  in {
    nixosConfigurations = {
      thinkcentre = lib'.mkHost {
        name = "thinkcentre";

        extraModules = [
          disko.nixosModules.disko
          nixos-facter-modules.nixosModules.facter
          {
            facter.reportPath =
              ./hosts/thinkcentre/facter.json;
          }
        ];
      };
    };
  };
}
