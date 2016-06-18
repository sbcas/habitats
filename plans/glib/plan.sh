pkg_origin=scassiba
pkg_name=glib
pkg_version=2.49.1
pkg_maintainer="Samuel Cassiba <s@cassiba.com>"
pkg_license=(gpl)
pkg_source=http://ftp.gnome.org/pub/gnome/sources/${pkg_name}/2.49/${pkg_name}-${pkg_version}.tar.xz
pkg_filename=${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=b2513ec8cb4271625b7b89b4f58b64fec01c5095023bd44df5cfe4819d68ae55
pkg_deps=(core/glibc)
pkg_build_deps=(core/coreutils core/gcc core/make core/zlib scassiba/pkg-config)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  ./configure --prefix=${pkg_prefix} \
              --enable-shared
  make
}
