pkg_origin=core
pkg_name=sgml-common
pkg_version=0.6.3
pkg_maintainer="Samuel Cassiba <s@cassiba.com>"
pkg_license=(apachev2)
pkg_source=ftp://sources.redhat.com/pub/docbook-tools/new-trials/SOURCES/sgml-common-0.6.3.tgz
pkg_shasum=7dc418c1d361123ffc5e45d61f1b97257940a8eb35d0bfbbc493381cc5b1f959
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/coreutils
  core/make
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  pushd $HAB_CACHE_SRC_PATH/$pkg_dirname > /dev/null
  sed -i'' -e "s@SGML_BASE_DIR=/usr/share/sgml@SGML_BASE_DIR=${pkg_prefix}/share/sgml@" config/sgml.conf
  sed -i'' -e "s@SGML_CATALOGS_DIR=/etc/sgml@SGML_CATALOGS_DIR=${pkg_prefix}/etc/sgml@" config/sgml.conf
  sed -i'' -e "s@/etc/sgml@${pkg_prefix}/etc/sgml@g" bin/install-catalog.in
  echo 'man_MANS = install-catalog.8' > doc/man/Makefile.am
  autoreconf -f -i
  popd > /dev/null
}

do_build() {
  ./configure --prefix=$pkg_prefix --sysconfdir=$pkg_prefix/etc
  make
}

do_install() {
  mkdir -p $pkg_prefix/etc/sgml
  make docdir=$pkg_prefix/doc install
  install-catalog --add $pkg_prefix/etc/sgml/sgml-ent.cat \
    $pkg_prefix/share/sgml/sgml-iso-entities-8879.1986/catalog
  install-catalog --add $pkg_prefix/etc/sgml/sgml/sgml-docbook.cat \
    $pkg_prefix/etc/sgml/sgml-ent.cat
}
