# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ri/Attic/ri-1.8b.ebuild,v 1.9 2004/08/30 17:25:23 usata Exp $

DESCRIPTION="Ruby Interactive reference"
HOMEPAGE="http://www.pragmaticprogrammer.com/ruby/downloads/ri.html"
SRC_URI="mirror://sourceforge/rdoc/${P}.tgz"

SLOT="0"
LICENSE="Ruby"
KEYWORDS="alpha hppa mips sparc x86 ~ppc"

IUSE=""
DEPEND="=dev-lang/ruby-1.6*"

S=${WORKDIR}/${PN}

src_install () {

	DESTDIR=${D} ruby16 install.rb || die "install.rb failed"
	dodoc COPYING ChangeLog README
}
