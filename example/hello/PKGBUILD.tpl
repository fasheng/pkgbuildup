pkgname=hello
pkgver={% pkgver %}
pkgrel={% pkgrel %}
pkgdesc='Hello package from Debian'
arch=('i686' 'x86_64')
depends=()
license=('GPL3')
provides=("${pkgname}")
url="http://www.debian.com/"
_parent_url="http://ftp.debian.org/debian/pool/main/h/hello"
_filename_x86="{% filename_x86 %}"
_filename_x64="{% filename_x64 %}"
_md5_x86="{% md5_x86 %}"
_md5_x64="{% md5_x64 %}"
if test "$CARCH" == i686; then
    _filename=${_filename_x86}
    _md5=${_md5_x86}
else    
    _filename=${_filename_x64}
    _md5=${_md5_x64}
fi
source=("${_parent_url}/${_filename}")
md5sums=("${_md5}")

package() {
    tar xvf ${srcdir}/data.tar.xz -C ${pkgdir}/
}
