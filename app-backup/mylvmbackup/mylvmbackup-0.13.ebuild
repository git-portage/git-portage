# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/mylvmbackup/mylvmbackup-0.13.ebuild,v 1.2 2010/04/29 07:33:16 robbat2 Exp $

inherit eutils

DESCRIPTION="mylvmbackup is a tool for quickly creating backups of MySQL server's data files using LVM snapshots"
HOMEPAGE="http://lenz.homelinux.org/mylvmbackup/"
SRC_URI="http://lenz.homelinux.org/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
DEPEND=""
RDEPEND="dev-perl/Config-IniFiles
		>=sys-fs/lvm2-2.02.06
		dev-perl/DBD-mysql
		virtual/mysql
		dev-perl/TimeDate"

src_unpack() {
	unpack ${A}
	sed -i \
		-e '/^prefix/s,/usr/local,/usr,' \
		"${S}"/Makefile
	sed -i 's|mycnf=/etc/my.cnf|mycnf=/etc/mysql/my.cnf|' "${S}"/mylvmbackup.conf
}

src_install() {
	emake install DESTDIR="${D}" mandir="/usr/share/man"
	dodoc ChangeLog README TODO
	keepdir /var/tmp/${PN}/{backup,mnt}
	fperms 0700 /var/tmp/${PN}/
}
