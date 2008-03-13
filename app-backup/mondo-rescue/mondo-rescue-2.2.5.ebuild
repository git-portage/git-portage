# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/mondo-rescue/Attic/mondo-rescue-2.2.5.ebuild,v 1.1 2008/03/13 10:58:44 wschlich Exp $

inherit libtool

DESCRIPTION="The premier GPL disaster recovery solution."
HOMEPAGE="http://www.mondorescue.org"
SRC_URI="ftp://ftp.mondorescue.org/src/${PN/-rescue/}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ia64 ~amd64"
IUSE=""
DEPEND="virtual/libc
	>=sys-libs/slang-1.4.1
	>=dev-libs/newt-0.50"
RDEPEND="app-arch/afio
	sys-block/buffer
	sys-devel/binutils
	>=app-arch/bzip2-0.9
	virtual/cdrtools
	>=sys-apps/mindi-2.0.0
	>=dev-libs/newt-0.50
	>=sys-libs/slang-1.4.1
	sys-apps/parted
	>=sys-boot/syslinux-1.52"

S="${WORKDIR}/${PN/-rescue/}-${PV}"

src_compile() {
	elibtoolize
	chmod 750 configure
	econf || die "Configuration failed"
	emake VERSION=${PV} || die "Make failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	mkdir -p "${D}"/var/cache/mondo
	exeinto /usr/share/mondo
	doexe mondo/autorun
}

pkg_postinst() {
	einfo "${PN} was successfully installed."
	einfo "Please read the associated docs for help."
	einfo "Or visit the website @ ${HOMEPAGE}"
	echo
	ewarn "Please report bugs to http://bugs.gentoo.org/"
	ewarn "However, please do an advanced query to search for bugs"
	ewarn "before reporting. This will keep down on duplicates."
	echo
	einfo "Prior to running mondo, ensure /boot is mounted."
	ewarn "Grub users need to have a symlink like this:"
	ewarn "ln -s /boot/grub/menu.lst /etc/grub.conf"
	einfo "Unless you want to have mondo backup your distfiles,"
	einfo "append \"-E ${DISTDIR}\" to your mondoarchive command."
	echo
}
