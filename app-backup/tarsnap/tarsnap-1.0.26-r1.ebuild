# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/tarsnap/Attic/tarsnap-1.0.26-r1.ebuild,v 1.1 2010/01/06 21:19:18 gregkh Exp $

DESCRIPTION="Online backups for the truly paranoid"
HOMEPAGE="http://www.tarsnap.com/"
SRC_URI="https://www.tarsnap.com/download/tarsnap-autoconf-${PV}.tgz"

LICENSE="tarsnap"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="sys-libs/zlib dev-libs/openssl sys-libs/e2fsprogs-libs"
RDEPEND="${DEPEND}"

S="${WORKDIR}/tarsnap-autoconf-${PV}"

src_install() {
	einstall || die "tarsnap could not be installed"
}
