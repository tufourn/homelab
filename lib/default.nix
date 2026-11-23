{
  self,
  inputs,
  nixpkgs,
  ...
}: {
  mkHost = {
    name,
    system ? "x86_64-linux",
    extraModules ? [],
  }:
    nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs self;
      };

      modules =
        [
          (../hosts + "/${name}")
        ]
        ++ extraModules;
    };
}
