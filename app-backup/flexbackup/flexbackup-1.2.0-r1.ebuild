# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/flexbackup/Attic/flexbackup-1.2.0-r1.ebuild,v 1.2 2007/01/24 04:17:10 genone Exp $

DESCRIPTION="Flexible backup script using perl"
HOMEPAGE="http://flexbackup.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="dev-lang/perl
	sys-apps/findutils
	app-arch/tar
	app-arch/mt-st"

src_compile() {
	emake BINPATH="/usr/bin" || die "compile problem"
}

src_install() {
	dodir /etc /usr/bin
	einstall CONFFILE="${D}/etc/flexbackup.conf" BINPATH="${D}/usr/bin"

	dosed "/^\$type = /s:'afio':'tar':" /etc/flexbackup.conf
	dosed "/^\$buffer = /s:'buffer':'false':" /etc/flexbackup.conf

	dodoc CHANGES CREDITS INSTALL README TODO
	dohtml faq.html
}

pkg_postinst() {
	elog "Please edit your /etc/flexbackup.conf file to suit your"
	elog "needs.  If you are using devfs, the tape device should"
	elog "be set to /dev/tapes/tape0/mtn.  If you need to use any"
	elog "archiver other than tar, please emerge it separately."
}
