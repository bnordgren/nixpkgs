args: with args;

assert stdenv.gcc.gcc != null;

# NOTE: ! If Scribus doesn't render text try another font.

# a lot of templates, colour palettes, colour profiles or gradients
# will be released with the next version of scribus - So don't miss them
# when upgrading this package

#let useCairo = true;
let useCairo = false;

in

stdenv.mkDerivation {

  name = "scribus-1.3.3.14";

  src = fetchurl {
    url = mirror://sourceforge/scribus/scribus/1.3.3.14/scribus-1.3.3.14.tar.bz2;
    sha256 = "1ig7x6vxhqgjlpnv6hkzpb6gj4yvxsrx7rw900zlp7g6zxl01iyy";
  };

  cmakeFlags = if useCairo then "-DWANT_CAIRO=1" else "";

  configurePhase = ''
    set -x
    mkdir -p build;
    cd build
    eval -- "cmake .. $cmakeFlags"
    set +x
  '';

  buildInputs =
    [ pkgconfig /*<- required fro cairo only?*/ cmake freetype lcms libtiff libxml2 libart_lgpl qt
      python cups fontconfig
      libXaw libXext libX11 libXtst libXi libXinerama
      libjpeg libtiff zlib libpng
    ] ++ lib.optional useCairo cairo;

  # fix rpath which is removed by cmake..
  postFixup = ''
    for i in $buildNativeInputs ${stdenv.gcc.gcc}; do
      [ -d "$i/lib" ] && RPATH="$RPATH:$i/lib"
      [ -d "$i/lib64" ] && RPATH="$RPATH:$i/lib64"
    done
    patchelf --set-rpath "''\${RPATH:1}" $out/bin/scribus
  '';

  meta = {
    maintainers = [lib.maintainers.marcweber];
    platforms = lib.platforms.linux;
    description = "Desktop Publishing (DTP) and Layout program for Linux.";
    homepage = http://www.scribus.net;
    license = "GPLv2";
  };
}

