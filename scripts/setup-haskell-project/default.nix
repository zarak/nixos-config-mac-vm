{ lib, pkgs, ... }:

let
  version = "0.0.1.0";
in
pkgs.stdenv.mkDerivation rec {
  pname = "setup-haskell-project";
  inherit version;

  src = ./.;

  installPhase = ''
    mkdir -p $out/bin
    cp setup-haskell-project $out/bin/
    chmod +x $out/bin/$pname
  '';
}
