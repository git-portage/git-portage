# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/mylvmbackup/Attic/mylvmbackup-0.6.ebuild,v 1.1 2007/12/04 18:29:00 robbat2 Exp $

inherit eutils

DESCRIPTION="mylvmbackup is a Perl script for quickly creating backups of MySQL server's data files utilizing LVM snapshots."
HOMEPAGE="http://lenz.homelinux.org/mylvmbackup/"
SRC_URI="http://lenz.homelinux.org/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
DEPEND=">=app-text/asciidoc-8.1.0"
RDEPEND="dev-perl/Config-IniFiles
		>=sys-fs/lvm2-2.02.06
		dev-perl/DBD-mysql
		virtual/mysql"

src_unpack() {
	unpack ${A}
	sed -i \
		-e '/^prefix/s,/usr/local,/usr,' \
		${S}/Makefile
}

src_install() {
	emake -j1 install DESTDIR="${D}"
	dodoc ChangeLog README TODO
	keepdir /var/tmp/${PN}/{backup,mnt}
}
