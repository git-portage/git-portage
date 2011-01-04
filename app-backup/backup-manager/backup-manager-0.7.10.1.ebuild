# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/backup-manager/Attic/backup-manager-0.7.10.1.ebuild,v 1.1 2011/01/04 15:32:09 voyageur Exp $

EAPI=2

inherit eutils

MY_P=Backup-Manager-${PV}
DESCRIPTION="Backup Manager is a command line backup tool for GNU/Linux."
HOMEPAGE="http://www.backup-manager.org/"
SRC_URI="http://www.backup-manager.org/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc s3"

DEPEND="dev-lang/perl
	sys-devel/gettext"

RDEPEND="${DEPEND}
	>=sys-apps/findutils-4.3.0
	s3? ( dev-perl/Net-Amazon-S3
		dev-perl/File-Slurp )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i "/^PERL5DIR/s/sitelib/vendorlib/" "${S}"/Makefile || die
	epatch "${FILESDIR}"/${PN}-0.7.9-parallel_install.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	use doc && dodoc doc/user-guide.txt
}

pkg_postinst() {
	elog "After installing,"
	elog "copy ${ROOT%/}/usr/share/backup-manager/backup-manager.conf.tpl to"
	elog "/etc/backup-manager.conf and customize it for your environment."
	elog "You could also set-up your cron for daily or weekly backup."
	ebeep 3
	ewarn "New configuration keys have been defined. Please check the docs for info"
}
