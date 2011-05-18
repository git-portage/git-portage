# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/tob/tob-0.26-r2.ebuild,v 1.1 2011/05/18 07:26:57 xmw Exp $

EAPI=2

inherit eutils

DESCRIPTION="A general driver for making and maintaining backups."
HOMEPAGE="http://tinyplanet.ca/projects/tob/"
SRC_URI="http://tinyplanet.ca/projects/tob/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="app-arch/afio"
DEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-no-maketemp-warn.diff
	epatch "${FILESDIR}"/${P}-nice.patch
	epatch "${FILESDIR}"/${P}-scsi-tape.diff
	rm -rf `find . -name CVS` || die
}

src_install() {
	dosbin tob || die
	dodir /var/lib/tob || die
	insinto /etc/tob
	doins tob.rc || die
	insinto /etc/tob/volumes
	doins example.* || die

	dodoc README contrib/tobconv || die
	docinto doc
	dodoc doc/* || die
	docinto sample-rc
	dodoc sample-rc/* || die
	doman tob.8 || die
}
