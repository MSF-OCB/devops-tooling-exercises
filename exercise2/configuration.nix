{
  imports = [ ./services.nix ];

  fileSystems."/" = {
    device = "/dev/null";
    fsType = "ext4";
  };

  boot.loader.grub.device = "/dev/null";

  system.stateVersion = "22.05";
}
