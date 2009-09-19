/* A Hydra jobset to test Guile-using applications and libraries with the
   Guile 2.x pre-releases.

   -- ludo@gnu.org  */

let
  allPackages = import ./all-packages.nix;

  pkgs = allPackages {
    config = {
      packageOverrides = (p: p // { guile = p.guile_1_9; });
    };
  };

  toJob = x: if builtins.isAttrs x then x else
    { type = "job"; systems = x; schedulingPriority = 10; };

  /* Perform a job on the given set of platforms.  The function `f' is
     called by Hydra for each platform, and should return some job
     to build on that platform.  `f' is passed the Nixpkgs collection
     for the platform in question. */
  testOn = systems: f: {system ? builtins.currentSystem}:
    if pkgs.lib.elem system systems
    then f (allPackages {inherit system;})
    else {};

  /* Map an attribute of the form `foo = [platforms...]'  to `testOn
     [platforms...] (pkgs: pkgs.foo)'. */
  mapTestOn = pkgs.lib.mapAttrsRecursiveCond
    (as: !(as ? type && as.type == "job"))
    (path: value:
      let
        job = toJob value;
        getPkg = pkgs:
          pkgs.lib.addMetaAttrs { schedulingPriority = toString job.schedulingPriority; }
          (pkgs.lib.getAttrFromPath path pkgs);
      in testOn job.systems getPkg);

  inherit (pkgs.lib.platforms) linux darwin cygwin allBut all;

in (mapTestOn {
  /* The package list below was obtained with:

     cat top-level/all-packages.nix				\
     | grep -B3 'guile[^=]*$'					\
     | grep '^[[:blank:]]*[a-zA-Z0-9_]\+[[:blank:]]*='		\
     | sed -es'/^[[:blank:]]*\(.\+\)[[:blank:]]*=.*$/\1= linux;/g'

     with some minor edits.
   */

  guile = linux;

  lsh = linux;
  mailutils = linux;
  mcron = linux;
  guileLib = linux;
  guileLint = linux;
  gwrap = linux;
  gnutls = linux;
  dico = linux;
  trackballs = linux;
  beast = linux;
  elinks = linux;
  gnunet = linux;
  snd = linux;
  ballAndPaddle = linux;
  drgeo = linux;
  lilypond = linux;
})
