# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/kdar/Attic/kdar-2.1.0-r1.ebuild,v 1.1 2009/02/22 15:01:50 carlo Exp $

EAPI="2"

ARTS_REQUIRED="never"

inherit kde flag-o-matic

DESCRIPTION="KDE Disk Archiver."
HOMEPAGE="http://kdar.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="dar32 dar64"

DEPEND=">=app-backup/dar-2.3.5[dar32?,dar64?]
	>=app-arch/bzip2-1.0.2
	>=sys-libs/zlib-1.1.4"
RDEPEND="${DEPEND}"

need-kde 3.5

PATCHES=(
	"${FILESDIR}/kdar-2.1.0-desktop-file.diff"
	"${FILESDIR}/kdar-2.1.0-as-needed.diff"
	)

src_prepare() {
	# empty, EAPI 2 eclass incompatibility.
	:
}

src_compile() {
	local myconf

	# Bug 116112
	replace-flags "-Os" "-O2"

	use dar32 && myconf="${myconf} --enable-mode=32"
	use dar64 && myconf="${myconf} --enable-mode=64"

	kde_src_compile
}
