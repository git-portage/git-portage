# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/vyqchat/Attic/vyqchat-0.2.3.ebuild,v 1.7 2004/07/24 01:14:16 swegener Exp $

inherit eutils

DESCRIPTION="QT based Vypress Chat clone for X."
HOMEPAGE="http://linux.bydg.org/~yogin/"
SRC_URI="http://linux.bydg.org/~yogin/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE="arts"

DEPEND=">=x11-libs/qt-3.0
	arts? ( kde-base/arts )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/vyqchat_packet_id.patch
}

src_compile() {
	econf \
		--with-x \
		--with-Qt-dir=/usr/qt/3 \
		$(use_with arts) \
		|| die "econf failed"
	make || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc README THANKS NEWS || die "dodoc failed"
}
