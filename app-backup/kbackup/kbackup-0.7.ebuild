# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/kbackup/Attic/kbackup-0.7.ebuild,v 1.3 2011/01/28 15:26:39 scarabeus Exp $

EAPI=3

KDE_HANDBOOK="optional"
KDE_LINGUAS="cs de es fr it pt pt_BR ru sk sv"
inherit kde4-base

DESCRIPTION="KBackup is a program that lets you back up any directories or files."
HOMEPAGE="http://kde-apps.org/content/show.php/KBackup?content=44998"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/44998-${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="4"
KEYWORDS="amd64 x86"
IUSE="debug"
