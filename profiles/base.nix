{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/sd-image.nix>
    <nixpkgs/nixos/modules/profiles/clone-config.nix>
  ];

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  powerManagement.enable = lib.mkDefault true;
  hardware.bluetooth.enable = lib.mkDefault true;
  hardware.enableAllFirmware = lib.mkDefault true;

  networking.networkmanager.enable = lib.mkDefault (pkgs.stdenv.system == "aarch64-linux");

  # dont need :)
  services.nixosManual.enable = lib.mkDefault false;
  programs.man.enable = lib.mkDefault false;
  programs.info.enable = lib.mkDefault false;

  # Allow the user to log in as root without a password.
  users.extraUsers.root.initialHashedPassword = "";
}
