# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/tob/Attic/tob-0.26-r1.ebuild,v 1.2 2005/07/05 09:50:56 dholm Exp $

inherit eutils

DESCRIPTION="A general driver for making and maintaining backups."
HOMEPAGE="http://tinyplanet.ca/projects/tob/"
SRC_URI="http://tinyplanet.ca/projects/tob/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

RDEPEND="app-arch/afio"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-no-maketemp-warn.diff || die
	epatch ${FILESDIR}/${P}-nice.patch || die
	epatch ${FILESDIR}/${P}-scsi-tape.diff || die
}

src_compile() {
	# no compilation required, only a perl-script
	einfo "No compilation necessary..."
}

src_install() {
	# simply install all the parts into the correct places
	dosbin tob || die
	dodir /etc/tob/volumes
	cp tob.rc ${D}/etc/tob/tob.rc
	cp example.* ${D}/etc/tob/volumes
	doman tob.8
	dodoc README
	docinto doc
	dodoc doc/*
	docinto sample-rc
	dodoc sample-rc/*
	einfo "creating the TOBLISTS directory ..."
	dodir /var/lib/tob
}

