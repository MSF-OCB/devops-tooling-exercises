{
  imports = [ ./users.nix ];

  networking.hostName = "srv002";

  fileSystems."/" = {
    device = "/dev/null";
    fsType = "ext4";
  };

  boot.loader.grub.device = "/dev/null";

  system.stateVersion = "22.05";
}
