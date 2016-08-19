pkg_origin=core
pkg_name=rabbitmq
pkg_version=3.6.5
pkg_maintainer="Samuel Cassiba <s@cassiba.com>"
pkg_license=(apachev2)
pkg_source=nonexistent.tar.gz
#pkg_source=https://www.rabbitmq.com/releases/rabbitmq-server/v3.6.5/rabbitmq-server-3.6.5.zip
#pkg_shasum=4b9505358325862bbf5f69bb213281755175144b4d7cefe64005e19aaae2880d
pkg_deps=(core/glibc core/erlang)
pkg_build_deps=(core/coreutils core/unzip core/python2 core/cacerts core/make core/zlib core/bzip2 core/git)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_verify() {
  return 0
}

do_unpack() {
  return 0
}

do_download() {
  export GIT_SSL_CAINFO="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
  git clone https://github.com/rabbitmq/rabbitmq-server $HAB_CACHE_SRC_PATH/rabbitmq-server
  tar -cjf $HAB_CACHE_SRC_PATH/rabbitmq-server-${pkg_version}.tar.bz2 \
      --transform "s,^\./rabbitmq-server,rabbitmq-server-${pkg_version}," $HAB_CACHE_SRC_PATH/rabbitmq-server \
      --exclude rabbitmq-server/.git
  pkg_shasum=$(trim $(sha256sum $HAB_CACHE_SRC_PATH/${pkg_filename} | cut -d " " -f 1))
}

do_build() {
  pushd $HAB_CACHE_SRC_PATH/rabbitmq-server > /dev/null
  make
  popd > /dev/null
}
