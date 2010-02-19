# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/duplicity/Attic/duplicity-0.6.06.ebuild,v 1.2 2010/02/19 23:15:00 abcd Exp $

EAPI="3"

inherit distutils

DESCRIPTION="duplicity is a secure backup system using gnupg to encrypt data"
HOMEPAGE="http://www.nongnu.org/duplicity/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="s3"

DEPEND=">=dev-lang/python-2.3
	>=net-libs/librsync-0.9.6
	>=net-ftp/ncftp-3.1.9
	app-crypt/gnupg"
RDEPEND="${DEPEND}
	>=dev-python/py-gnupg-0.3.2
	>=dev-python/pexpect-2.1
	s3? ( dev-python/boto )"

src_install() {
	distutils_src_install
	rm "${ED}"/usr/share/doc/${P}/COPYING
}
