# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="meson"
PKG_VERSION="0.60.3"
PKG_SHA256="87ca5fa9358a01864529392bd64e027158eb94afca7c7766b1866ef27eccb98e"
PKG_LICENSE="Apache"
PKG_SITE="http://mesonbuild.com"
PKG_URL="https://github.com/mesonbuild/meson/releases/download/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="Python3:host setuptools:host pathlib:host"
PKG_LONGDESC="High productivity build system"
PKG_TOOLCHAIN="manual"

make_host() {
  python3 setup.py build
}

makeinstall_host() {
  exec_thread_safe python3 setup.py install --prefix=${TOOLCHAIN} --skip-build

  # Avoid using full path to python3 that may exceed 128 byte limit.
  # Instead use PATH as we know our toolchain is first.
  sed -e '1 s/^#!.*$/#!\/usr\/bin\/env python3/' -i ${TOOLCHAIN}/bin/meson
}
