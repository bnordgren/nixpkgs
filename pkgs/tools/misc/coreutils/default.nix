{stdenv, fetchurl}:

stdenv.mkDerivation {
  name = "coreutils-5.97";
  src = fetchurl {
    url = ftp://ftp.nluug.nl/pub/gnu/coreutils/coreutils-5.97.tar.gz;
    md5 = "bdec4b75c76ac9bf51b6dd1747d3b06e";
  };
}
