# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/tarsnap/Attic/tarsnap-1.0.26.ebuild,v 1.1 2010/01/06 19:24:13 gregkh Exp $

DESCRIPTION="Online backups for the truly paranoid"
HOMEPAGE="http://www.tarsnap.com/"
SRC_URI="https://www.tarsnap.com/download/tarsnap-autoconf-${PV}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="net-misc/curl sys-libs/readline dev-libs/libxml2 dev-libs/libpcre"
RDEPEND="${DEPEND}"

S="${WORKDIR}/tarsnap-autoconf-${PV}"

src_install() {
	einstall || die "tarsnap could not be installed"
#	dodoc bti.example README RELEASE-NOTES ||
#		die "bti documentation could not be installed"
#	dobashcompletion bti-bashcompletion
}
