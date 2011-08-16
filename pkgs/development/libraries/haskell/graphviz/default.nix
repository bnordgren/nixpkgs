{ cabal, colour, dlist, extensibleExceptions, fgl, polyparse, text
, transformers, wlPprintText
}:

cabal.mkDerivation (self: {
  pname = "graphviz";
  version = "2999.12.0.2";
  sha256 = "0hjivsayxnkzh51rw80fr95hw7kfdpiw0gjq2hpnv1hfqmjrw4vy";
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    colour dlist extensibleExceptions fgl polyparse text transformers
    wlPprintText
  ];
  meta = {
    homepage = "http://projects.haskell.org/graphviz/";
    description = "Bindings to Graphviz for graph visualisation";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [
      self.stdenv.lib.maintainers.andres
      self.stdenv.lib.maintainers.simons
    ];
  };
})
