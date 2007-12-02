# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/duplicity/Attic/duplicity-0.4.6.ebuild,v 1.1 2007/12/02 08:55:40 ticho Exp $

inherit distutils

DESCRIPTION="duplicity is a secure backup system using gnupg to encrypt data"
HOMEPAGE="http://www.nongnu.org/duplicity/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/libc
	>=dev-lang/python-2.3
	>=net-libs/librsync-0.9.6
	net-ftp/ncftp"
RDEPEND="${DEPEND}
	dev-python/py-gnupg
	>=dev-python/pexpect-2.1"
