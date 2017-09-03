{ stdenv, hostPlatform, pkgs, perl, buildLinux, ... } @ args:

let
   mkArmbianPatch = path: {
     name = "armbian-${path}";
     patch = "${pkgs.armbian}/patch/kernel/${path}";
   };
   armbianPatches = [
     "sun8i-dev/add-ad9834-dt-bindings.patch"
     "sun8i-dev/add-BergMicro-SPI-flashes.patch"
     "sun8i-dev/add-configfs-overlay-for-v4.11.x.patch"
     "sun8i-dev/add-dvfs-emac-nanopi.patch"
     "sun8i-dev/add-emac-pwr-en-orangepi-plus2e.patch"
     "sun8i-dev/add-fix-dts-for-opi-zero-emac.patch"
     "sun8i-dev/add-h3-overlays.patch"
     "sun8i-dev/add-h3-simplefb.patch"
     "sun8i-dev/add-nanopi-neoair.patch"
     "sun8i-dev/add-orangepi-zeroplus.patch"
     "sun8i-dev/add-overlay-compilation-support.patch"
     "sun8i-dev/add-realtek-8189fs-driver.patch"
     "sun8i-dev/add-spi-aliases.patch"
     "sun8i-dev/add-spi-flash-opi-zero.patch"
     "sun8i-dev/Add_support_for_Xbox_One_Digital_TV_Tuner.patch"
     "sun8i-dev/add-thermal-otg-wireless-opi-lite.patch"
     "sun8i-dev/add-uart-rts-cts-pins.patch"
     "sun8i-dev/add-wifi-pwrseq-opi-pc-plus.patch"
     "sun8i-dev/enable-1200mhz-on-small-orangepis.patch"
     "sun8i-dev/enable-codec-opi-2.patch"
     "sun8i-dev/fix-broken-usb0-drv.patch"
     "sun8i-dev/fix-i2c2-reg-property.patch"
     "sun8i-dev/fix-missing-eth0-alias-to-avoid-random-mac.patch"
     "sun8i-dev/increasing_DMA_block_memory_allocation_to_2048.patch"
     "sun8i-dev/packaging-4.x-DEV-with-postinstall-scripts.patch"
     "sun8i-dev/resolve-crypto-deps.patch"
     "sun8i-dev/scripts-dtc-import-updates.patch"
     "sun8i-dev/spidev-remove-warnings.patch"
     "sun8i-dev/spi-sun6i-allow-large-transfers.patch"
   ];
   armbianKernelPatches = map (n: mkArmbianPatch n) armbianPatches;
 in import <nixpkgs/pkgs/os-specific/linux/kernel/generic.nix> (args // rec {
  version = "4.13";
  modDirVersion = "4.13.0-rc7";
  extraMeta.branch = "4.13";

  src = pkgs.fetchFromGitHub {
    owner = "megous";
    repo = "linux";
    rev = "601a3e793535243a3b07f5fe5c8423f8643c480f";
    sha256 = "1dg4x6vimn556mh1k2wdpqri43dpdxpaps1jih889v4bp5h5zfwb";
  };

  kernelPatches = pkgs.linux_4_12.kernelPatches;

  features.iwlwifi = false;
  features.efiBootStub = true;
  features.needsCifsUtils = true;
  features.netfilterRPFilter = true;
} // (args.argsOverride or {}))