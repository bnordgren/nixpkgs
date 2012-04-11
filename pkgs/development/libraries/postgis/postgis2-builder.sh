
source $stdenv/setup

tar zxf $src

cd postgis-2.0.0

./autogen.sh

./configure $configureFlags
# make the static liblwgeom library
make -C liblwgeom

# modify postgis libtool to make it more nix friendly
sed -i 's|^build_old_libs=yes|build_old_libs=no|g' libtool
sed -i 's|^dlopen_support=unknown|dlopen_support=yes|g' libtool
sed -i 's|^dlopen_self=unknown|dlopen_self=yes|g' libtool
sed -i 's|^dlopen_self_static=unknown|dlopen_self_static=no|g' libtool
sed -i 's|^hardcode_libdir_flag_spec=.*|hardcode_libdir_flag_spec="\''${wl}-rpath \''${wl}\$libdir"|g' libtool

make 
make install
