# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/cdbackup/cdbackup-0.7.0.ebuild,v 1.1 2006/05/28 23:45:01 lisa Exp $

inherit eutils

DESCRIPTION="Allows streaming backup utilities to dump/restore from CD-R(W)s or DVD(+/-RW)s"
HOMEPAGE="http://www.muempf.de/index.html"
SRC_URI="http://www.muempf.de/down/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="virtual/libc
	>=app-cdr/cdrtools-1.11.28"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A} ; cd ${S}

	sed -i \
		-e "s:^PREFIX=/usr/local$:PREFIX=\${DESTDIR}/usr:" Makefile \
			|| die "sed Makefile failed"
}

src_compile() {
	make DESTDIR="${D}" || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc CHANGES CREDITS README LICENSE
}
