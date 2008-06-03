# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/ccollect/Attic/ccollect-0.7.0-r1.ebuild,v 1.1 2008/06/03 20:07:55 dev-zero Exp $

EAPI="1"

DESCRIPTION="(pseudo) incremental backup with different exclude lists using hardlinks and rsync"
HOMEPAGE="http://unix.schottelius.org/ccollect/"
SRC_URI="http://unix.schottelius.org/ccollect/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="doc"

DEPEND="doc? ( >=app-text/asciidoc-8.1.0
		app-text/docbook-xsl-stylesheets
		app-text/docbook-xml-dtd:4.2
		dev-libs/libxslt )"
RDEPEND="net-misc/rsync"

src_compile() {
	if use doc; then
		make XSL=/usr/share/sgml/docbook/xsl-stylesheets/html/docbook.xsl documentation
	else
		einfo 'Nothing to compile'
	fi
}

src_install() {
	dobin ccollect.sh
	dosym ccollect.sh /usr/bin/ccollect

	local tools="add_source analyse_logs delete_source list_intervals logwrapper stats"
	for t in ${tools} ; do
		newbin tools/ccollect_${t}.sh ccollect_${t}
	done

	insinto /usr/share/${PN}/tools
	doins tools/config-pre* tools/{gnu-du-backup-size-compare,report_success}.sh

	dodoc CREDITS README doc/CHANGES

	if use doc; then
		dohtml doc/*.htm doc/*.html
		dohtml -r doc/man
		doman doc/man/*.1

		# dodoc is not recursive. So do a workaround.
		insinto /usr/share/doc/${PF}/examples/
		cp -Rdp "${S}/conf" "${D}/usr/share/doc/${PF}/examples/"
	fi
}

pkg_postinst() {
	ewarn "If you're upgrading from 0.6.x or less, you'll have to"
	ewarn "upgrade your existing configuration as follows:"
	ewarn "1. Make the scripts in /usr/share/ccollect/scripts executable"
	ewarn "2. Run all config-pre-\$VER-to-\$VER.sh in /usr/share/ccollect/scripts"
	ewarn "   ascending order, where \$VER is greater or equal than the version"
	ewarn "   you upgraded from."
	ewarn "Example:"
	ewarn "  You upgraded from 0.5, thus you have to run:"
	ewarn "  /usr/share/ccollect/tools/config-pre-0.6-to-0.6.sh"
	ewarn "  /usr/share/ccollect/tools/config-pre-0.7-to-0.7.sh"
	elog "Please note that many tools are now installed directly to /usr/bin"
	elog "as recommended by upstream."
}
