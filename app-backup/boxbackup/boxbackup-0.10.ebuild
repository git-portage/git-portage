# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/boxbackup/boxbackup-0.10.ebuild,v 1.3 2006/10/22 13:49:24 peper Exp $

inherit eutils

DESCRIPTION="A completely automatic on-line backup system"
HOMEPAGE="http://www.fluffy.co.uk/boxbackup/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc-macos ~x86"
IUSE="client-only"
DEPEND="sys-libs/zlib
	sys-libs/db
	>=dev-libs/openssl-0.9.7
	>=dev-lang/perl-5.6
	>=sys-devel/autoconf-2.50"
RDEPEND="${DEPEND}
	virtual/mta"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}"-gentoo.patch
	epatch "${FILESDIR}/${P}"-gcc41-noll.patch
}

src_compile() {
	./bootstrap || die "bootstrap failed"
	econf || die "configure failed"
	make || die
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	make DESTDIR="${D}" install-backup-client || die "client install failed"
	use client-only || \
		make DESTDIR="${D}" install-backup-server || die "server install failed"

	dodoc *.txt
	exeinto /etc/init.d
	newexe ${FILESDIR}/bbackupd.rc bbackupd
	use client-only || \
		newexe ${FILESDIR}/bbstored.rc bbstored

	keepdir /etc/boxbackup

	# move executables from /usr/bin to /usr/sbin, as configuration of
	# this is unfortunately not optimal
	mv "${D}/usr/bin" "${D}/usr/sbin" || die "could not move files from bin to sbin"
}

pkg_preinst() {
	if ! use client-only;
	then
		enewgroup bbstored
		enewuser bbstored -1 -1 -1 bbstored
	fi
}

pkg_postinst() {
	while read line; do einfo "${line}"; done <<EOF
After configuring the Box Backup client and/or server, you can start
the daemon using the init scripts /etc/init.d/bbackupd and
/etc/init.d/bbstored.
The configuration files can be found in /etc/boxbackup

More information about configuring the client can be found at
${HOMEPAGE}client.html,
and more information about configuring the server can be found at
${HOMEPAGE}server.html.
EOF
	echo
}
