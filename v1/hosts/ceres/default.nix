{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix

    ../../common/types/server.nix
    ../../common/modules/samba.nix

    ../../users/mladen
  ];

  networking = {
    hostName = "ceres";
    hostId = "8425e349";

    # It is secured well enough from my computer illiterate family.
    # Other required ports are explicitly redirecting to the host.
    # It's just more convenient to deal with it this way �\_(?)_/�
    firewall.enable = false;

    # Set up static IP
    useDHCP = false;
    interfaces.enp1s0f0 = {
      useDHCP = false;
      ipv4.addresses = [{
        address = "192.168.1.69";
        prefixLength = 24;
      }];
    };

    defaultGateway = {
      address = "192.168.1.1";
      interface = "enp1s0f0";
    };

    networkmanager = {
      enable = true;

      insertNameservers = [
        "127.0.0.1" # I usually run a pihole
        "1.1.1.1"
        "1.0.0.1"
      ];
    };
  };

  # Run garbage collection every day at 03:00
  nix.gc = {
    automatic = true;
    dates = "03:00";
  };

  # Minimal compatibility version. Ne need to touch.
  # https://nixos.org/manual/nixos/stable/options.html#opt-system.stateVersion
  system.stateVersion = "22.05";
}
