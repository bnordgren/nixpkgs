{ stdenv, fetchurl, ncurses, groff }:

stdenv.mkDerivation rec {
  name = "libedit-20110802-3.0";

  src = fetchurl {
    url = "http://www.thrysoee.dk/editline/${name}.tar.gz";
    sha256 = "0wcamisq6pj7hsk6apnqpb0bk34x7vcss6bqv8f7dzzs86mcjphb";
  };

  # Have `configure' avoid `/usr/bin/nroff' in non-chroot builds.
  NROFF = "${groff}/bin/nroff";

  postInstall = ''
    sed -i s/-lncurses/-lncursesw/g $out/lib/pkgconfig/libedit.pc
  '';

  configureFlags = "--enable-widec";

  propagatedBuildInputs = [ ncurses ];

  meta = {
    homepage = "http://www.thrysoee.dk/editline/";
    description = "A port of the NetBSD Editline library (libedit)";
  };
}
