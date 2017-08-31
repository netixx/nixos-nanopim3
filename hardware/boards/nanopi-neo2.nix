{ config, lib, pkgs, ... }:

with lib;
let
  platforms = (import ../platforms.nix);
in
{
  imports = [
    ./include/common.nix
  ];

  nixpkgs.config.writeBootloader = ''
    # Write bootloader to sd image
    dd if=${pkgs.uboot-nanopi-neo2}/sunxi-spl.bin conv=notrunc of=$out bs=1024 seek=8
    dd if=${pkgs.uboot-nanopi-neo2}/u-boot.img conv=notrunc of=$out bs=1024 seek=40
  '';

  boot.kernelPackages = pkgs.linuxPackages_sunxi64;
  boot.extraTTYs = [ "ttyS0" ];
  nixpkgs.config.platform = platforms.aarch64-multiplatform;
  networking.hostName = "nanopi-neo2";

}
