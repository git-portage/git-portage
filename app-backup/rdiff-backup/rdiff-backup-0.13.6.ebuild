# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/rdiff-backup/Attic/rdiff-backup-0.13.6.ebuild,v 1.2 2005/08/20 09:52:20 grobian Exp $

inherit distutils

DESCRIPTION="Remote incremental file backup utility, similar to rsync but more reliable"
HOMEPAGE="http://www.nongnu.org/rdiff-backup/"
SRC_URI="http://www.nongnu.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc-macos ~sparc ~x86"
IUSE=""

RDEPEND=">=net-libs/librsync-0.9.7"
