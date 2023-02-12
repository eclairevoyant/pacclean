_pkgname=pacclean
pkgname="$_pkgname-git"
pkgver=0
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
	install -Dm755 $_pkgname -t "$pkgdir/usr/bin/"
}
