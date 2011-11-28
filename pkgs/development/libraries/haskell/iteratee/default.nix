{ cabal, ListLike, MonadCatchIOTransformers, parallel, transformers
}:

cabal.mkDerivation (self: {
  pname = "iteratee";
  version = "0.8.7.3";
  sha256 = "1aqrqsd4q3isvv8dxaq61sgkns6lr7xabmllxp717f1jrnij7f54";
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    ListLike MonadCatchIOTransformers parallel transformers
  ];
  meta = {
    homepage = "http://www.tiresiaspress.us/haskell/iteratee";
    description = "Iteratee-based I/O";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [
      self.stdenv.lib.maintainers.andres
      self.stdenv.lib.maintainers.simons
    ];
  };
})