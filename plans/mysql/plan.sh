pkg_name=mysql
pkg_origin=core
pkg_version=5.7.14
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('GPL-2.0')
pkg_source=http://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-5.7.14.tar.gz
pkg_shasum=f7415bdac2ca8bbccd77d4f22d8a0bdd7280b065bd646a71a506b77c7a8bd169

pkg_deps=(
  core/glibc
  core/gcc-libs
  core/pcre
)

pkg_build_deps=(
  core/cmake
  core/coreutils
  core/diffutils
  core/expect
  core/patch
  core/make
  core/gcc
  core/bzip2-musl
  core/git
  core/curl
  core/which
  core/wget
  core/boost159
  core/python2
)

pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  cmake . -DLOCAL_BOOST_DIR=$(pkg_path_for boost159) \
          -DBOOST_INCLUDE_DIR=$(pkg_path_for boost159)/include \
          -DWITH_BOOST=$(pkg_path_for boost159) \
          -DCMAKE_INSTALL_PREFIX=$pkg_prefix
  make -j8
}
