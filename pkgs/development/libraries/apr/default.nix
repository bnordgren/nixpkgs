{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "apr-1.3.9";

  src = fetchurl {
    url = "mirror://apache/apr/${name}.tar.bz2";
    sha256 = "1qicxnk62d9mjza8vch2wxy4xlq8sa76chwi5cp6bs4cyj9s61ap";
  };

  configureFlags =
    # Don't use accept4 because it's only supported on Linux >= 2.6.28.
    [ "apr_cv_accept4=no" ]
    # Including the Windows headers breaks unistd.h.
    # Based on ftp://sourceware.org/pub/cygwin/release/libapr1/libapr1-1.3.8-2-src.tar.bz2
    ++ stdenv.lib.optional (stdenv.system == "i686-cygwin") "ac_cv_header_windows_h=no";
  
  meta = {
    homepage = http://apr.apache.org/;
    description = "The Apache Portable Runtime library";
  };
}
