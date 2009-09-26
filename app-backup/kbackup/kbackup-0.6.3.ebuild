# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/kbackup/Attic/kbackup-0.6.3.ebuild,v 1.1 2009/09/26 10:12:18 scarabeus Exp $

EAPI="2"

KDE_LINGUAS="de es fr it pt pt_BR ru sk sv"
inherit kde4-base

DESCRIPTION="KBackup is a program that lets you back up any directories or files."
HOMEPAGE="http://kde-apps.org/content/show.php/KBackup?content=44998"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/44998-${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"
