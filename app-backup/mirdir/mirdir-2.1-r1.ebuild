# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/mirdir/mirdir-2.1-r1.ebuild,v 1.1 2010/04/15 19:52:24 idl0r Exp $

EAPI=3

DESCRIPTION="Mirdir allows to synchronize two directory trees in a fast way"
HOMEPAGE="http://sf.net/projects/mirdir"
SRC_URI="mirror://sourceforge/${PN}/${P}-Unix.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${P}-UNIX"

src_prepare() {
	# Disable stripping, bug 239939
	sed -i -e 's:strip .*::' Makefile.in || die
}

src_install() {
	dobin bin/mirdir || die
	doman mirdir.1
	dodoc AUTHORS
}
