# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/luckybackup/Attic/luckybackup-0.3.5.ebuild,v 1.2 2009/12/18 17:20:47 ssuominen Exp $

EAPI=2
inherit qt4

DESCRIPTION="Powerful and flexible backup (and syncing) tool, using RSync and Qt4"
HOMEPAGE="http://luckybackup.sourceforge.net/"
SRC_URI="http://downloads.sourceforge.net/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4[debug?]
	net-misc/rsync"

src_prepare() {
	sed -i \
		-e 's:/usr/share/doc/luckybackup:/usr/share/doc/${PF}:g' \
		-e 's:/usr/share/doc/packages/luckybackup:/usr/share/doc/${PF}:g' \
		luckybackup.pro src/global.h || die
}

src_configure() {
	eqmake4
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die
	dodoc readme/*
}
