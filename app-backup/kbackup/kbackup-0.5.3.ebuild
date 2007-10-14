# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/kbackup/Attic/kbackup-0.5.3.ebuild,v 1.1 2007/10/14 19:31:46 keytoaster Exp $

inherit kde

DESCRIPTION="KBackup is a program that lets you back up any directories or files."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=44998"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/44998-${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=">=app-arch/bzip2-1.0.2
	>=sys-libs/zlib-1.1.4"

LANGS="de es fr it pt ru sk sv"

LANGS_DOC="de fr"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

need-kde 3.5

src_unpack() {
	kde_src_unpack

	cd "${WORKDIR}/${P}/po"
	for X in ${LANGS} ; do
		use linguas_${X} ||	rm "${X}.gmo" "${X}.po"
	done
	rm -f "${S}/configure"
	if ! use doc ; then
		rm -rf "${WORKDIR}/${P}/doc"
	else
		cd "${WORKDIR}/${P}/doc"
		for X in ${LANGS_DOC} ; do
			use linguas_${X} || rm -rf ${X}
		done
	fi
}
