# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/ccollect/Attic/ccollect-0.2.ebuild,v 1.1 2006/01/14 17:42:38 killerfox Exp $

DESCRIPTION="(pseudo) incremental backup with different exclude lists using
hardlinks and rsync"
HOMEPAGE="http://linux.schottelius.org/ccollect/"
SRC_URI="http://linux.schottelius.org/ccollect/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~hppa ~ppc"
IUSE="doc"

DEPEND=""
RDEPEND="sys-devel/bc
	     net-misc/rsync"

src_install() {
	dobin ccollect.sh

	if use doc; then
		dodoc doc/*

		# dodoc is not recursive. So do a workaround.
		insinto /usr/share/doc/${PF}/examples/
		doins -r ${S}/conf
	fi
}

