{ cabal, repa, vector }:

cabal.mkDerivation (self: {
  pname = "repa-algorithms";
  version = "2.1.0.1";
  sha256 = "101j18s2vqaxls87jzrlhzy2hlhqvgs27cs89j187c1s8z5vvjjg";
  buildDepends = [ repa vector ];
  meta = {
    homepage = "http://repa.ouroborus.net";
    description = "Algorithms using the Repa array library.";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [
      self.stdenv.lib.maintainers.andres
      self.stdenv.lib.maintainers.simons
    ];
  };
})
