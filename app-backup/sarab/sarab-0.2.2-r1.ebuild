# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/sarab/Attic/sarab-0.2.2-r1.ebuild,v 1.1 2006/01/06 16:47:43 mkennedy Exp $

inherit eutils

DESCRIPTION="SaraB is a powerful and automated backup scheduling system based on DAR."
HOMEPAGE="http://sarab.sourceforge.net/"
SRC_URI="mirror://sourceforge/sarab/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="app-backup/dar
	mail-client/mailx"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-test-with-encryption-gentoo.patch || die
	epatch ${FILESDIR}/${PV}-better-defaults-gentoo.patch || die
	epatch ${FILESDIR}/${PV}-fix-rotation-gentoo.patch || die
}

src_install() {
	dobin sarab.sh
	insinto /etc/sarab
	doins -r etc/*
	# sarab.conf could contain passphrase information
	fperms 600 /etc/sarab/sarab.conf
	dodoc CHANGELOG FAQ INSTALL LICENSE README
	dodoc ${FILESDIR}/README.Gentoo
}
