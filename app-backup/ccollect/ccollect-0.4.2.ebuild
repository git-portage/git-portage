# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/ccollect/Attic/ccollect-0.4.2.ebuild,v 1.2 2006/06/18 18:07:09 killerfox Exp $

DESCRIPTION="(pseudo) incremental backup with different exclude lists using
hardlinks and rsync"
HOMEPAGE="http://linux.schottelius.org/ccollect/"
SRC_URI="http://linux.schottelius.org/ccollect/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~hppa ~ppc ~x86"
IUSE="doc"

DEPEND="doc? ( >=app-text/asciidoc-7.0.2
	app-text/docbook2X )"
RDEPEND="sys-devel/bc
	net-misc/rsync
	app-arch/pax"

src_compile() {
	if use doc; then
		make documentation
	else
		einfo 'Nothing to compile'
	fi
}

src_install() {
	dobin ccollect.sh

	insinto /usr/share/${PN}/tools
	doins tools/*

	if use doc; then
		dodoc doc/*

		# dodoc is not recursive. So do a workaround.
		insinto /usr/share/doc/${PF}/examples/
		doins -r ${S}/conf
	fi
}

pkg_postinst() {
	ewarn "If you're upgrading from 0.3.X or less, please run"
	ewarn "/usr/share/ccollect/tools/config-pre-0.4-to-0.4.sh"
	ewarn "because the old configuration is no longer compatible."
}

