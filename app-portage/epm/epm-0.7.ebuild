# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/epm/Attic/epm-0.7.ebuild,v 1.3 2004/03/08 23:27:47 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="rpm workalike for Gentoo Linux"
SRC_URI="http://www.gentoo.org/~agriffis/epm/${P}.tar.gz"
HOMEPAGE="http://www.gentoo.org/~agriffis/epm/"
KEYWORDS="x86 amd64 ppc sparc"
SLOT="0"
LICENSE="GPL-2"
RDEPEND=">=dev-lang/perl-5"

src_install() {
	dobin epm
}
