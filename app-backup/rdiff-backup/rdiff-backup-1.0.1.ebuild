# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/rdiff-backup/Attic/rdiff-backup-1.0.1.ebuild,v 1.5 2006/06/27 19:21:53 corsair Exp $

inherit distutils

DESCRIPTION="Remote incremental file backup utility; uses librsync's rdiff utility to create concise, versioned backups."
HOMEPAGE="http://www.nongnu.org/rdiff-backup/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ppc ~ppc-macos ~ppc64 sparc x86"
IUSE=""

DEPEND=">=net-libs/librsync-0.9.7"
RDEPEND="${DEPEND}"
