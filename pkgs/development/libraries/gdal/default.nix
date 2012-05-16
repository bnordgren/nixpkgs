{ stdenv, fetchurl, composableDerivation, unzip, libjpeg, libtiff, zlib, postgresql, mysql, libgeotiff, coreutils }:

composableDerivation.composableDerivation {} (fixed: {
  name = "gdal-1.9.0";

  src = fetchurl {
    url = http://download.osgeo.org/gdal/gdal-1.9.0.tar.gz ;
    md5 = "1853f3d8eb5232ae030abe007840cade" ; 
  };

  buildInputs = [ unzip libjpeg coreutils ];

  # don't use optimization for gcc >= 4.3. That's said to be causeing segfaults
  # preConfigure = "export CFLAGS=-O0; export CXXFLAGS=-O0";
  preConfigure = "sed -i 's#^BINTRUE=/bin/true#BINTRUE=${coreutils}/bin/true#' configure" ;

  configureFlags = [
    "--with-jpeg=${libjpeg}"
    "--with-libtiff=${libtiff}"  # optional (without largetiff support
    "--with-libz=${zlib}"        # optional

    "--with-pg=${postgresql}/bin/pg_config"
    "--with-mysql=${mysql}/bin/mysql_config"
    "--with-geotiff=${libgeotiff}"
    "--without-libtool"
  ];

  meta = {
    description = "Translator library for raster geospatial data formats";
    homepage = http://www.gdal.org/;
    license = "X/MIT";
    maintainers = [ stdenv.lib.maintainers.marcweber ];
    platforms = stdenv.lib.platforms.linux;
  };
})
