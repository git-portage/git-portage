# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/hdup/hdup-2.0.14.ebuild,v 1.3 2007/05/17 16:27:20 chtekk Exp $

KEYWORDS="~amd64 ~x86"
DESCRIPTION="Hdup is backup program using tar, find, gzip/bzip2, mcrypt and ssh."
HOMEPAGE="http://www.miek.nl/projects/hdup2/index.html"
SRC_URI="http://www.miek.nl/projects/${PN}2/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
IUSE="crypt"

DEPEND="app-arch/bzip2
		app-arch/gzip
		app-arch/tar
		dev-util/pkgconfig
		net-misc/openssh
		sys-apps/coreutils
		sys-apps/findutils
		crypt? ( app-crypt/mcrypt )"

RDEPEND="${DEPEND}"

src_compile() {
	econf || die "conf failed"
	emake || die "make failed"
}

src_install() {
	dodir /usr/sbin
	make DESTDIR="${D}" install || die "install failed"

	dohtml doc/FAQ.html
	dodoc ChangeLog Credits README

	insinto /usr/share/${PN}/contrib/
	doins contrib/*

	insinto /usr/share/${PN}/examples/
	doins examples/*
}

pkg_postinst() {
	elog "Now edit your /etc/hdup/${PN}.conf to configure your backups."
	elog "You can also check included examples and contrib, see /usr/share/${PN}/."
}
