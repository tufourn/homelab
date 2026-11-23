{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
    colmena.url = "github:nix-community/colmena";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    disko,
    nixos-facter-modules,
    colmena,
    ...
  }: {
    colmenaHive = colmena.lib.makeHive {
      meta = {
        nixpkgs = import nixpkgs {
          system = "x86_64-linux";
          overlays = [];
        };
        specialArgs = {inherit inputs;};
      };

      thinkcentre = {imports = [hosts/thinkcentre];};
    };
  };
}
