{ lib, pkgs, ... }:

with lib;
let
  platforms = (import ../platforms.nix);
in {
  imports = [
    ./include/common.nix
    ./include/h3.nix
  ];

  system.build.dtbName = "sun8i-h2-plus-orangepi-zero.dtb";
  system.build.bootloader = pkgs.uboot-nanopi-neo;
  networking.hostName = "nanopi-neo";

  meta = {
    platforms = [ "armv7l-linux" ];
  };

}
