# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/kbackup/Attic/kbackup-0.5.1.ebuild,v 1.1 2006/10/15 19:55:34 deathwing00 Exp $

inherit kde

DESCRIPTION="KBackup is a program that lets you back up any directories or files."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=44998"
SRC_URI="http://www.kde-apps.org/content/files/44998-${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND=">=app-arch/bzip2-1.0.2
	>=sys-libs/zlib-1.1.4"

LANGS="de fr it ru sk"

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

