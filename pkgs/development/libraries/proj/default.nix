{ stdenv, fetchurl }:

stdenv.mkDerivation {
  name = "proj-4.8.0";

  src = fetchurl {
    url = ftp://ftp.remotesensing.org/proj/proj-4.8.0.tar.gz;
    sha256 = "1dfim63ks298204lv2z0v16njz6fs7bf0m4icy09i3ffzvqdpcid"; 
  };

  meta = { 
    description = "Cartographic Projections Library";
    homepage = http://proj.maptools.org;
    license = "MIT";
  };
}
