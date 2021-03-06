{ stdenv, binutils, openssl, fetchFromGitHub, pkgs }:

stdenv.mkDerivation rec {
    version="0.1";
    name = "cpuminer-multi-${version}";

    src = fetchFromGitHub {
      owner = "effectsToCause";
      repo = "veriumMiner";
      rev = "521c697c43de0e34f71331b3732d90781db93f53";
      sha256 = "0gh9amsgia3ilzigcc07g78vp3q37ivb887dpq9sy85zjhmy0wvr";
    };

    patches = [
      ../patches/fix-compile.patch
    ];

    hardeningDisable = [ "all" ];
    nativeBuildInputs = [ pkgs.autoreconfHook pkgs.jansson pkgs.curl pkgs.gcc7 ];
    enableParallelBuilding = true;

    configureFlags = ''
      --with-crypto
      --with-curl
    '';

    CFLAGS = "-O3 -march=native";

    meta = {
      description = "cpuminer-multi";
      maintainers = [ stdenv.lib.maintainers.georgewhewell ];
      platforms = [
        "armv7l-linux"
        "aarch64-linux"
      ];
    };

}
