{ composableDerivation, fetchurl, python }:

let inherit (composableDerivation) edf; in

composableDerivation.composableDerivation {} {

  flags =
  # python and ruby untested 
    edf { name = "python"; enable = { buildInputs = [ python ]; }; };
    # (if args.use_svn then ["libtool" "autoconf" "automake" "swig"] else [])
    # // edf { name = "ruby"; enable = { buildInputs = [ ruby ]; };}

  name = "geos-3.3.2";

  src = fetchurl {
    url = http://download.osgeo.org/geos/geos-3.3.2.tar.bz2;
    sha256 = "ec64d3a92540a1618aa3b91dc1235caae1c370ec23afd59a2734062bf182ed5b" ;
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
