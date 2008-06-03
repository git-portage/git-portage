# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/ccollect/Attic/ccollect-0.7.0.ebuild,v 1.1 2008/06/03 10:36:19 dev-zero Exp $

DESCRIPTION="(pseudo) incremental backup with different exclude lists using hardlinks and rsync"
HOMEPAGE="http://unix.schottelius.org/ccollect/"
SRC_URI="http://unix.schottelius.org/ccollect/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="doc"

DEPEND="doc? ( >=app-text/asciidoc-7.0.2 )"
RDEPEND="net-misc/rsync"

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

	dodoc CREDITS README

	if use doc; then
		dodoc doc/*

		# dodoc is not recursive. So do a workaround.
		insinto /usr/share/doc/${PF}/examples/
		doins -r "${S}/conf"
	fi
}

pkg_postinst() {
	ewarn "If you're upgrading from 0.6.X or less, please run"
	ewarn "/usr/share/ccollect/tools/config-pre-0.7-to-0.7.sh"
	ewarn "because the old configuration is no longer compatible."
}
