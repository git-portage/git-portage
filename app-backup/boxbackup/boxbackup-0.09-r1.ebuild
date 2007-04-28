# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/boxbackup/Attic/boxbackup-0.09-r1.ebuild,v 1.4 2007/04/28 16:40:44 swegener Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A completely automatic on-line backup system"
HOMEPAGE="http://www.fluffy.co.uk/boxbackup/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz
	mirror://gentoo/${P}-solaris.patch.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc-macos x86"
IUSE="client-only"
DEPEND="sys-libs/zlib
	sys-libs/db
	>=dev-libs/openssl-0.9.7
	>=dev-lang/perl-5.6"
RDEPEND="${DEPEND}
	virtual/mta"

src_unpack() {
	unpack ${A}

	epatch "${DISTDIR}/${P}"-solaris.patch.bz2
	epatch "${FILESDIR}/${P}"-darwin.patch
	epatch "${FILESDIR}/${P}"-gentoo.patch
}

src_compile() {
	# note, we can't use econf here, because configure is a wrapper
	# around a perl script, not the configure you would normally
	# expect!!!
	local myconf=""
	# GCC4 hack, see
	# http://lists.warhead.org.uk/pipermail/boxbackup/2005-August/001625.html
	[ "$(gcc-major-version)" -eq "4" ] && myconf="compile:-DPLATFORM_GCC3"
	./configure ${myconf} || die
	make || die
}

src_install() {
	# For the same reason why we can't use econf and emake, we can't do
	# make install here either, because the installation is some lame
	# script.

	# create directories the installscript assumes to exist
	mkdir -p ${D}/usr/sbin
	make DESTDIR=${D} install || die "install failed"
	make DESTDIR=${D} install-backup-client || die "client install failed"
	use client-only || \
		make DESTDIR=${D} install-backup-server || die "server install failed"

	dodoc *.txt
	newinitd ${FILESDIR}/bbackupd.rc bbackupd
	use client-only || \
		newexe ${FILESDIR}/bbstored.rc bbstored

	keepdir /etc/boxbackup
}

pkg_preinst() {
	if ! use client-only;
	then
		enewgroup bbstored
		enewuser bbstored -1 -1 -1 bbstored
	fi
}

pkg_postinst() {
	while read line; do elog "${line}"; done <<EOF
After configuring the boxbackup client and/or server, you can start
the boxbackup daemons using the init scripts /etc/init.d/bbackupd
and /etc/init.d/bbstored.
More information about configuring the client can be found at
${HOMEPAGE}client.html,
and more information about configuring the server can be found at
${HOMEPAGE}server.html.
EOF
}
