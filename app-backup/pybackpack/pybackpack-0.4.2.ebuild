# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/pybackpack/pybackpack-0.4.2.ebuild,v 1.1 2006/06/02 08:04:16 robbat2 Exp $

inherit distutils

DESCRIPTION="GTK+ GUI for the rdiff-backup tool"
SRC_URI="http://minus-zero.org/projects/pybackpack/${P}.tar.gz"
HOMEPAGE="http://sucs.org/~davea/trac/wiki"

IUSE=""
SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"
DEPEND=">=dev-lang/python-2.4
		>=app-backup/rdiff-backup-0.12.7
		>=dev-python/gnome-python-desktop-2.14.0"
