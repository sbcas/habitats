pkg_origin=scassiba
pkg_name=pkg-config
pkg_version=0.29.1
pkg_maintainer="Samuel Cassiba <s@cassiba.com>"
pkg_license=(gpl)
pkg_source=https://${pkg_name}.freedesktop.org/releases/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=beb43c9e064555469bd4390dcfd8030b1536e0aa103f08d7abf7ae8cac0cb001
pkg_deps=(core/glibc)
pkg_build_deps=(core/coreutils core/gcc core/make)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  ./configure --prefix=${pkg_prefix} \
              --with-internal-glib
  make
}
