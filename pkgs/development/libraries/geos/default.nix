{ composableDerivation, fetchurl, python }:

let inherit (composableDerivation) edf; in

composableDerivation.composableDerivation {} {

  flags =
  # python and ruby untested 
    edf { name = "python"; enable = { buildInputs = [ python ]; }; };
    # (if args.use_svn then ["libtool" "autoconf" "automake" "swig"] else [])
    # // edf { name = "ruby"; enable = { buildInputs = [ ruby ]; };}

  name = "geos-3.3.3";

  src = fetchurl {
    url = http://download.osgeo.org/geos/geos-3.3.3.tar.bz2;
    sha256 = "1jfypprjx263zpd5caq98njh3wa88yw027fjpavsa4mj1bblpkyz" ;
  };

  # for development version. can be removed ?
  #configurePhase = "
  #  [ -f configure ] || \\
  #  LIBTOOLIZE=libtoolize ./autogen.sh
  #  [>{ automake --add-missing; autoconf; }
  #  unset configurePhase; configurePhase
  #";

  meta = {
    description = "C++ port of the Java Topology Suite (JTS)";
    homepage = http://geos.refractions.net/;
    license = "GPL";
  };
}
