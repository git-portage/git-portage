# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/kbackup/Attic/kbackup-0.5.4-r1.ebuild,v 1.4 2009/10/17 13:06:24 ssuominen Exp $

EAPI="2"

USE_KEG_PACKAGING="1"

ARTS_REQUIRED="never"

LANGS="de es fr it pt ru sk sv"

LANGS_DOC="de fr"

inherit kde

DESCRIPTION="KBackup is a program that lets you back up any directories or files."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=44998"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/44998-${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="3.5"
KEYWORDS="x86"
IUSE=""

DEPEND=">=app-arch/bzip2-1.0.2
	>=sys-libs/zlib-1.1.4"
RDEPEND="${DEPEND}"

need-kde 3.5
