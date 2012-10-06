# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/obnam/Attic/obnam-1.2.ebuild,v 1.1 2012/10/06 23:48:23 mschiff Exp $

EAPI=4

PYTHON_DEPEND="2:2.6:2.7"
PYTHON_MODNAME="${PN}lib"
MY_P="${PN}_${PV}.orig"

inherit distutils python

DESCRIPTION="A backup program that supports encryption and deduplication"
HOMEPAGE="http://liw.fi/obnam/"
SRC_URI="http://code.liw.fi/debian/pool/main/o/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/cliapp-1.20120630
	dev-python/larch
	dev-python/paramiko
	dev-python/tracing
	>=dev-python/ttystatus-0.19
	"
RDEPEND="${DEPEND}"

# S="${WORKDIR}/${MY_P}"

src_install() {
	distutils_src_install
	rm "${D}"/usr/bin/obnam-{benchmark,viewprof}
	rm "${D}"/usr/share/man/man1/obnam-benchmark*
	insinto /etc
	doins "${FILESDIR}"/obnam.conf
}
