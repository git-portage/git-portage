# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/kdar/Attic/kdar-2.1.0_beta1.ebuild,v 1.1 2008/04/04 01:27:23 matsuu Exp $

inherit kde

MY_P="${P/_/-}"
DESCRIPTION="KDE Disk Archiver."
HOMEPAGE="http://kdar.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="dar32 dar64"

DEPEND=">=app-backup/dar-2.3.5
	>=app-arch/bzip2-1.0.2
	>=sys-libs/zlib-1.1.4"

S="${WORKDIR}/${MY_P}"

need-kde 3.3

src_compile() {
	local myconf

	# Bug 116112
	replace-flags "-Os" "-O2"

	use dar32 && myconf="${myconf} --enable-mode=32"
	use dar64 && myconf="${myconf} --enable-mode=64"
	kde_src_compile
}
