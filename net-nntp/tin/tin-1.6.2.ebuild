# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/tin/Attic/tin-1.6.2.ebuild,v 1.3 2005/05/16 17:01:24 swegener Exp $

inherit versionator

DESCRIPTION="A threaded NNTP and spool based UseNet newsreader"
HOMEPAGE="http://www.tin.org/"
SRC_URI="ftp://ftp.tin.org/pub/news/clients/tin/v$(get_version_component_range 1-2)/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc arm ~amd64 ia64 ~ppc-macos"
IUSE="ncurses ipv6"

DEPEND="ncurses? ( sys-libs/ncurses )"

src_compile() {
	local myconf=""
	[ -f /etc/NNTP_INEWS_DOMAIN ] \
		&& myconf="${myconf} --with-domain-name=/etc/NNTP_INEWS_DOMAIN"

	econf \
		--verbose \
		--enable-nntp-only \
		--enable-prototypes \
		--disable-echo \
		--disable-mime-strict-charset \
		--with-coffee  \
		--enable-fascist-newsadmin \
		$(use_enable ncurses curses) \
		$(use_with ncurses) \
		$(use_enable ipv6) \
		${myconf} || die "econf failed"
	emake build || die "emake failed"
}

src_install() {
	dobin src/tin || die "dobin failed"
	dosym tin /usr/bin/rtin || die "dosym failed"
	doman doc/tin.1 || die "doman failed"
	dodoc doc/* || die "dodoc failed"
	insinto /etc/tin
	doins doc/tin.defaults || die "doins failed"
}
