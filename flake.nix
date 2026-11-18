{
  description = "ThinkCentre M920q NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
  };

  outputs = {
    nixpkgs,
    disko,
    nixos-facter-modules,
    ...
  }: {
    nixosConfigurations.thinkcentre = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        disko.nixosModules.disko
        nixos-facter-modules.nixosModules.facter
        ./configuration.nix
        {
          config.facter.reportPath =
            if builtins.pathExists ./facter.json
            then ./facter.json
            else throw "Generate facter.json first";
        }
      ];
    };
  };
}
