{ stdenv, fetchurl, libtiff }:

stdenv.mkDerivation {
  name = "libgeotiff-1.3.0";

  src = fetchurl {
    url = http://download.osgeo.org/geotiff/libgeotiff/libgeotiff-1.3.0.tar.gz ;
    sha256 = "09qd8hprk7rl7v9kjc4z1mv4rxc1zmbzf7jmv9x8dic1089yk8hg" ;
  };

  buildInputs = [ libtiff ];

  meta = {
    description = "Library implementing attempt to create a tiff based interchange format for georeferenced raster imagery";
    homepage = http://trac.osgeo.org/geotiff ;
    license = "X11";
    maintainers = [stdenv.lib.maintainers.marcweber];
    platforms = stdenv.lib.platforms.linux;
  };
}
