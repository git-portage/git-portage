# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/cpdup/Attic/cpdup-1.07.ebuild,v 1.1 2006/11/14 09:33:48 drizzt Exp $

inherit bsdmk

DESCRIPTION="A comprehensive filesystem mirroring program"
HOMEPAGE="http://apollo.backplane.com/FreeSrc/"
SRC_URI="http://apollo.backplane.com/FreeSrc/${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}"

src_install() {
	dobin cpdup
	doman cpdup.1
}
