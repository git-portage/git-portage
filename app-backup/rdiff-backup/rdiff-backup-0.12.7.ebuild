# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/rdiff-backup/Attic/rdiff-backup-0.12.7.ebuild,v 1.1 2005/07/04 06:32:54 robbat2 Exp $

inherit distutils

DESCRIPTION="Remote incremental file backup utility, similar to rsync but more reliable"
HOMEPAGE="http://www.nongnu.org/rdiff-backup/"
SRC_URI="http://www.nongnu.org/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~amd64"
IUSE=""
SLOT="0"

RDEPEND=">=net-libs/librsync-0.9.6"

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install
}
