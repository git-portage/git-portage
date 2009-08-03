# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/luckybackup/Attic/luckybackup-0.3.3.ebuild,v 1.1 2009/08/03 20:28:47 hwoarang Exp $

EAPI="2"
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
RDEPEND="${DEPEND}"

src_configure() {
	eqmake4
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "install failed"
	dohtml -r manual/* || die "dohtml failed"
}
