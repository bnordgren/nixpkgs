source $stdenv/setup

export LANG="en_US.UTF-8"
export LOCALE_ARCHIVE=$glibcLocales/lib/locale/locale-archive
export M2_REPO=$TMPDIR/repository

echo "XXXXX>>>>> Maven repository: " $M2_REPO

mkdir -p $TMPDIR
cp -r $src $TMPDIR/src
chmod -R u+w $TMPDIR/src
cd $TMPDIR/src
mvn -debug -Dmaven.repo.local=$M2_REPO install > $TMPDIR/build.log

mkdir -p $out
cp -r $TMPDIR/repository $out

