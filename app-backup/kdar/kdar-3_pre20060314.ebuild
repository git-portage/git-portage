# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/kdar/Attic/kdar-3_pre20060314.ebuild,v 1.2 2007/05/23 08:54:23 opfer Exp $

inherit kde flag-o-matic

MY_P="${PN}-snapshot-${PV#*_pre}"
DESCRIPTION="KDE Disk Archiver."
HOMEPAGE="http://kdar.sourceforge.net/"
SRC_URI="mirror://sourceforge/kdar/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="dar32 dar64"

RDEPEND=">=app-backup/dar-2.3.2-r1
	>=app-arch/bzip2-1.0.2
	>=sys-libs/zlib-1.1.4"
DEPEND="${RDEPEND}
	kde-base/kapptemplate"

S="${WORKDIR}/${MY_P}"

need-kde 3.3

src_unpack() {
	unpack ${A}
	cd "${S}"

	cp -pR "${KDEDIR}"/share/apps/kapptemplate/admin "${S}" || die
	chmod +x admin/*.pl || die
}

src_compile() {
	local myconf

	# Bug 116112
	replace-flags "-Os" "-O2"

	use dar32 && myconf="${myconf} --enable-mode=32"
	use dar64 && myconf="${myconf} --enable-mode=64"

	emake -f admin/Makefile.common || die
	kde_src_compile
}
