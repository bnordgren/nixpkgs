{cabal, HTTP, json, mtl, network} :

cabal.mkDerivation (self : {
  pname = "CouchDB";
  version = "0.10.1";
  sha256 = "1ny62ab0sjrkh7mpxj0ahqrv7c8dh0n5s1g8xl0mq3yiwlrjdsim";
  propagatedBuildInputs = [ HTTP json mtl network ];
  meta = {
    homepage = "http://github.com/arjunguha/haskell-couchdb/";
    description = "CouchDB interface";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.stdenv.lib.platforms.haskellPlatforms;
    maintainers = [ self.stdenv.lib.maintainers.simons ];
  };
})
