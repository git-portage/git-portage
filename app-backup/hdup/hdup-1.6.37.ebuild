# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/hdup/Attic/hdup-1.6.37.ebuild,v 1.5 2007/05/17 16:27:20 chtekk Exp $

KEYWORDS="~amd64 ~ppc x86"
DESCRIPTION="Hdup is backup program using tar, find, gzip/bzip2, mcrypt and ssh."
HOMEPAGE="http://www.miek.nl/projects/hdup16/hdup16.html"
SRC_URI="http://www.miek.nl/projects/hdup16/previous/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="app-arch/bzip2
		app-arch/gzip
		app-arch/tar
		net-misc/openssh
		sys-apps/coreutils
		sys-apps/findutils"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}16"

src_compile() {
	econf || die "conf failed"
	emake || die "make failed"
}

src_install() {
	dodir /usr/sbin
	make prefix="${D}/usr" mandir="${D}/usr/share/man" sysconfdir="${D}/etc" install || die "install failed"

	dohtml doc/FAQ.html
	dodoc ChangeLog Credits INSTALL
	dodoc examples/hdup.cron examples/no-history-post-run.sh
	dodoc contrib/cleanup.pl contrib/backup.pl
}

pkg_postinst() {
	elog "Now edit your /etc/hdup/${PN}.conf to configure your backups."
	elog "You can also check included examples and contrib, see /usr/share/doc/${P}/."
}
