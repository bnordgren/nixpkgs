# This program used to come with xorg releases, but now I could only find it
# at http://www.x.org/releases/individual/.
# That is why this expression is not inside pkgs.xorg

{stdenv, fetchurl, libX11, pkgconfig, libXaw, libXi, imake, xauth, libXau}:
stdenv.mkDerivation rec {
  name = "xfontsel-1.0.2";

  src = fetchurl {
    url = "http://www.x.org/releases/individual/app/${name}.tar.bz2";
    sha256 = "1a86a08sf0wjrki9ydh7hr5qf6hrixc4ljlxizakjzmx20wvlrks";
  };

  buildInputs = [libX11 pkgconfig libXaw];

  # This will not make xfontsel find its app-defaults, but at least the $out
  # directory will contain them.
  # hack: Copying the XFontSel app-defaults file to $HOME makes xfontsel work.
  patchPhase = ''
    sed -i 's@^appdefaultdir=.*@appdefaultdir='$out/share/X11/app-defaults@ configure
  '';
}

