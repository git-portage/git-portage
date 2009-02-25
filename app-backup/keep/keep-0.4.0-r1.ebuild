# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/keep/Attic/keep-0.4.0-r1.ebuild,v 1.1 2009/02/22 15:07:52 carlo Exp $

EAPI="1"

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="A simple backup system for KDE."
HOMEPAGE="http://jr.falleri.free.fr/keep/wiki/Home"
SRC_URI="http://jr.falleri.free.fr/files/devel/keep/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( kde-base/kcontrol:3.5 kde-base/kdebase:3.5 )
	>=app-backup/rdiff-backup-1.0.1-r1"

need-kde 3.5

PACTHES=(
	"${FILESDIR}/keep-0.4.0-desktop-file.diff"
	)

pkg_postinst() {
	kde_pkg_postinst

	elog "After initial install the Keep daemon needs to be started via KControl - Services."
	elog "The Keep daemon will be loaded automatically at the next KDE startup."
	echo
}
