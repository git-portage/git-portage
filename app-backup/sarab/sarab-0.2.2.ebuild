# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/sarab/Attic/sarab-0.2.2.ebuild,v 1.1 2005/07/25 22:23:31 mkennedy Exp $

inherit eutils

DESCRIPTION="SaraB is a powerful and automated backup scheduling system based on DAR."
HOMEPAGE="http://sarab.sourceforge.net/"
SRC_URI="mirror://sourceforge/sarab/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"					# work in progress
IUSE=""

DEPEND=""
RDEPEND="app-backup/dar"

S=${WORKDIR}/${PN}

src_install() {
	dobin sarab.sh
	insinto /etc/sarab
	doins -r etc/*
	dodoc CHANGELOG FAQ INSTALL LICENSE README
}
