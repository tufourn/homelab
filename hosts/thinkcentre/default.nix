{
  inputs,
  modulesPath,
  pkgs,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.disko.nixosModules.disko
    inputs.nixos-facter-modules.nixosModules.facter
    ./disko.nix
  ];

  facter.reportPath = ./facter.json;

  networking = {
    hostName = "thinkcentre";
    useDHCP = true;
  };

  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      efiInstallAsRemovable = true;
    };

    efi.canTouchEfiVariables = false;
  };

  services.openssh = {
    enable = true;

    settings = {
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false;
    };
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMA6cOq8mrhuV0gHWtSdlMEBa+4yHevLqC677fSz5lxb"
  ];

  environment.systemPackages = with pkgs; [
    curl
    gitMinimal
    vim
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "24.05";
}
