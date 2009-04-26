{ fetchurl, stdenv, perl, perlXMLParser, gettext, intltool
, pkgconfig, glib, gtk, gnomedocutils, gnomeicontheme
, libgnome, libgnomeui, scrollkeeper, libxslt
, libglade, dbus, dbus_glib
, poppler, libspectre, djvulibre, shared_mime_info
, makeWrapper, which }:

stdenv.mkDerivation rec {
  name = "evince-2.26.0";

  src = fetchurl {
    url = "http://ftp.gnome.org/pub/GNOME/sources/evince/2.26/${name}.tar.bz2";
    sha256 = "1wsl5vdrj0829wq223dryq5p7izgzsz6mfl4igix7b5wga42zff1";
  };

  buildInputs = [
    perl perlXMLParser gettext intltool
    pkgconfig glib gtk gnomedocutils gnomeicontheme
    libgnome libgnomeui libglade scrollkeeper
    libxslt  # for `xsltproc'
    dbus dbus_glib
    poppler libspectre djvulibre
    makeWrapper which
  ];

  configureFlags = "--with-libgnome --enable-dbus --enable-pixbuf "

    # Do not update Scrollkeeper's database (GNOME's help system).
    + "--disable-scrollkeeper";

  postInstall = ''
    # Tell Glib/GIO about the MIME info directory, which is used
    # by `g_file_info_get_content_type ()'.
    wrapProgram "$out/bin/evince" \
      --set XDG_DATA_DIRS "${shared_mime_info}/share"
  '';

  meta = {
    homepage = http://www.gnome.org/projects/evince/;
    description = "Evince, GNOME's document viewer";

    longDescription = ''
      Evince is a document viewer for multiple document formats.  It
      currently supports PDF, PostScript, DjVu, TIFF and DVI.  The goal
      of Evince is to replace the multiple document viewers that exist
      on the GNOME Desktop with a single simple application.
    '';

    license = "GPLv2+";
  };
}