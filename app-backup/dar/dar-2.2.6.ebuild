# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/dar/Attic/dar-2.2.6.ebuild,v 1.1 2006/02/11 15:48:51 matsuu Exp $

inherit flag-o-matic

DESCRIPTION="A full featured backup tool, aimed for disks (floppy,CDR(W),DVDR(W),zip,jazz etc.)"
HOMEPAGE="http://dar.linux.free.fr/"
SRC_URI="mirror://sourceforge/dar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="acl dar32 dar64 doc examples nls ssl static"

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
	use examples && myconf="${myconf} --enable-examples"
	use nls || myconf="${myconf} --disable-nls"
	use ssl || myconf="${myconf} --disable-libcrypto-linking"
	use static || myconf="${myconf} --enable-static=no --disable-dar-static"

	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	rm "${D}"/usr/share/dar/{[A-Z]*,*.html}

	dodoc AUTHORS BUGS ChangeLog NEWS README THANKS TODO
	dodoc doc/{COMMAND_LINE,FAQ,FEATURES,GOOD_BACKUP_PRACTICE,LIMITATIONS}
	dodoc doc/{LINKS,NOTES,TUTORIAL}
	dohtml doc/api_tutorial.html doc/mini-howto/*.html

	if use doc ; then
		dohtml doc/html/*
	fi
}
