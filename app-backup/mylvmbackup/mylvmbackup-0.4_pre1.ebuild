# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/mylvmbackup/Attic/mylvmbackup-0.4_pre1.ebuild,v 1.1 2007/01/12 13:03:10 robbat2 Exp $

inherit eutils

DESCRIPTION="mylvmbackup is a Perl script for quickly creating backups of MySQL server's data files utilizing LVM snapshots."
HOMEPAGE="http://lenz.homelinux.org/mylvmbackup/"
MY_PV=0.3
SRC_URI="http://lenz.homelinux.org/${PN}/${PN}-${MY_PV}.tar.gz
		mirror://gentoo/${PN}-0.3-to-0.4-changes.patch.gz
		http://dev.gentoo.org/~robbat2/${PN}-0.3-to-0.4-changes.patch.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
DEPEND=">=app-text/asciidoc-7.1.2"
RDEPEND="dev-perl/Config-IniFiles
		>=sys-fs/lvm2-2.02.10
		dev-perl/DBD-mysql
		virtual/mysql"

S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	unpack ${PN}-${MY_PV}.tar.gz
	epatch ${DISTDIR}/${PN}-0.3-to-0.4-changes.patch.gz
	sed -i \
		-e '/^VERSION/s,0.4,0.4_pre1,' \
		-e '/^prefix/s,/usr/local,/usr,' \
		${S}/Makefile
}

src_install() {
	emake -j1 install DESTDIR="${D}"
	dodoc ChangeLog README TODO
	keepdir /var/tmp/${PN}/{backup,mnt}
}
