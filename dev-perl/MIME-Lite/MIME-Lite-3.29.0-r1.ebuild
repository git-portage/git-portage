# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MIME-Lite/MIME-Lite-3.29.0-r1.ebuild,v 1.1 2014/08/21 19:02:41 axs Exp $

EAPI=5

MODULE_AUTHOR=RJBS
MODULE_VERSION=3.029
inherit perl-module

DESCRIPTION="Low-calorie MIME generator"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	dev-perl/Email-Date-Format
	>=dev-perl/MIME-Types-1.280.0
	dev-perl/MailTools
"
DEPEND="${RDEPEND}"

SRC_TEST=do

src_install() {
	perl-module_src_install
	insinto /usr/share/${PN}
	doins -r contrib
}
