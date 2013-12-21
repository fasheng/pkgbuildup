# There are six template variables: pkgver, pkgrel, fileurl_x86,
# fileurl_x64, md5_x86, and md5_x64. In this example we will see that
# pkgbuildup could dispatch multiple source files easily.
pkgname=hello
pkgver={% pkgver %}
pkgrel={% pkgrel %}
pkgdesc='Hello package from Debian'
arch=('i686' 'x86_64')
url="http://www.debian.com/"
license=('GPL3')
depends=()

_fileurl_x86="{% fileurl_x86 %}"
_fileurl_x64="{% fileurl_x64 %}"
_md5_x86="{% md5_x86 %}"
_md5_x64="{% md5_x64 %}"
if test "$CARCH" == i686; then
    _fileurl=${_fileurl_x86}
    _md5=${_md5_x86}
else
    _fileurl=${_fileurl_x64}
    _md5=${_md5_x64}
fi
source=("${_fileurl}")
md5sums=("${_md5}")

package() {
    tar xvf ${srcdir}/data.tar.xz -C ${pkgdir}/
}
