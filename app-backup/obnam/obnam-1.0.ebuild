# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/obnam/Attic/obnam-1.0.ebuild,v 1.1 2012/06/15 10:24:15 mschiff Exp $

EAPI=4

PYTHON_DEPEND="2:2.6:2.7"
PYTHON_MODNAME="${PN}lib"

inherit distutils python

DESCRIPTION="A backup program that supports encryption and deduplication"
HOMEPAGE="http://liw.fi/obnam/"
SRC_URI="http://code.liw.fi/debian/pool/main/o/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/larch
	dev-python/tracing
	dev-python/ttystatus
	dev-python/paramiko
	"
RDEPEND="${DEPEND}"

src_install() {
	distutils_src_install
	rm "${D}"/usr/bin/obnam-{benchmark,viewprof}
	rm "${D}"/usr/share/man/man1/obnam-benchmark*
}
