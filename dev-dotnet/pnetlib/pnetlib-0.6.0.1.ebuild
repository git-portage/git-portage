# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/pnetlib/Attic/pnetlib-0.6.0.1.ebuild,v 1.3 2004/01/03 23:21:08 scandium Exp $

DESCRIPTION="Portable .NET C# library"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="mirror://gnu/dotgnu/pnet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"

IUSE="X"

DEPEND="=dev-dotnet/pnet-0.6.0*
	X? ( virtual/x11 )"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README
	dodoc doc/*.txt
	dohtml doc/*.html
}
