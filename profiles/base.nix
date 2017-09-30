{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/profiles/clone-config.nix>
  ];

  boot.initrd.kernelModules = [ ];
  boot.initrd.availableKernelModules = [ "lz4" "lz4_compress" ];

  environment.variables.GC_INITIAL_HEAP_SIZE = "100000";
  boot.kernel.sysctl."vm.overcommit_memory" = "1";

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  powerManagement.enable = lib.mkDefault true;
  powerManagement.cpuFreqGovernor = "ondemand";

  # dont need :)
  services.nixosManual.enable = lib.mkDefault false;
  programs.man.enable = lib.mkDefault false;
  programs.info.enable = lib.mkDefault false;

  # Allow the user to log in as root without a password.
  users.extraUsers.root.initialHashedPassword = "";
}
