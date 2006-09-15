# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/dar/Attic/dar-2.3.1.ebuild,v 1.2 2006/09/15 17:30:02 matsuu Exp $

inherit flag-o-matic

DESCRIPTION="A full featured backup tool, aimed for disks (floppy,CDR(W),DVDR(W),zip,jazz etc.)"
HOMEPAGE="http://dar.linux.free.fr/"
SRC_URI="mirror://sourceforge/dar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
#IUSE="acl dar32 dar64 doc examples nls ssl"
IUSE="acl dar32 dar64 doc nls ssl"

DEPEND=">=sys-libs/zlib-1.2.3
	>=app-arch/bzip2-1.0.2
	acl? ( sys-apps/attr )
	doc? ( app-doc/doxygen )
	nls? ( sys-devel/gettext )
	ssl? ( dev-libs/openssl )"

src_compile() {
	local myconf="--disable-upx"

	# Bug 103741
	filter-flags -fomit-frame-pointer

	use acl || myconf="${myconf} --disable-ea-support"
	use dar32 && myconf="${myconf} --enable-mode=32"
	use dar64 && myconf="${myconf} --enable-mode=64"
	use doc || myconf="${myconf} --disable-build-html"
	# use examples && myconf="${myconf} --enable-examples"
	use nls || myconf="${myconf} --disable-nls"
	use ssl || myconf="${myconf} --disable-libcrypto-linking"

	econf ${myconf} || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" pkgdatadir=/usr/share/doc/${PF}/html install || die

	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
