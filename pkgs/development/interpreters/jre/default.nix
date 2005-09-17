{stdenv, fetchurl}: 

if stdenv.system == "i686-linux"
  then
    (import ./jre-sun-linux.nix) {
      inherit stdenv fetchurl;
    }
  else
    false
