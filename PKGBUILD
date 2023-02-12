# Maintainer: éclairevoyant

_pkgname=pacclean
pkgname="$_pkgname-git"
pkgver=r12.b308a97
pkgrel=1
pkgdesc="Clean up old pacman packages, similar to paccache"
arch=('x86_64')
url="https://github.com/eclairevoyant/pacclean"
license=('CCPL:by-nc-sa')
depends=('pacman' 'glibc')
makedepends=('git' 'nim')
source=("git+$url.git")
b2sums=('SKIP')

pkgver() {
	cd $_pkgname
	printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

build() {
	cd $_pkgname
	nimble release
}

package() {
	cd $_pkgname
	install -Dm755 bin/$_pkgname -t "$pkgdir/usr/bin/"
}
