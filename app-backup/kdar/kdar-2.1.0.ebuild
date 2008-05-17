# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/kdar/Attic/kdar-2.1.0.ebuild,v 1.1 2008/05/17 01:48:38 matsuu Exp $

ARTS_REQUIRED="never"
inherit flag-o-matic kde

DESCRIPTION="KDE Disk Archiver."
HOMEPAGE="http://kdar.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="dar32 dar64"

DEPEND=">=app-backup/dar-2.3.5
	>=app-arch/bzip2-1.0.2
	>=sys-libs/zlib-1.1.4"

need-kde 3.3

src_compile() {
	local myconf

	# Bug 116112
	replace-flags "-Os" "-O2"

	use dar32 && myconf="${myconf} --enable-mode=32"
	use dar64 && myconf="${myconf} --enable-mode=64"
	kde_src_compile
}
