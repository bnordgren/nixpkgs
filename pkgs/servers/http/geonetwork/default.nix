{stdenv, fetchurl}:

stdenv.mkDerivation {
  name = "geonetwork-2.6.4";

  builder = ./builder.sh ; 

  src = fetchurl {
    url = mirror://sourceforge/geonetwork/geonetwork.war;
    sha256 = "1awci5fs7a73p9i8rn31pkwdsd1v9f6qchqqmcacvihz44xgb7wv";
  };
}
