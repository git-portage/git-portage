# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/Attic/Attic-0.15.ebuild,v 1.1 2015/05/10 18:06:01 hanno Exp $

EAPI=5
PYTHON_COMPAT=( python{3_2,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Attic is a deduplicating backup program written in Python"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
HOMEPAGE="https://attic-backup.org/"

IUSE=""
SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64"

DEPEND="dev-python/msgpack
	dev-python/llfuse
	dev-python/pyopenssl"
