# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/pdumpfs/pdumpfs-1.3-r1.ebuild,v 1.3 2009/01/04 00:04:05 cla Exp $

DESCRIPTION="a daily backup system similar to Plan9's dumpfs"
HOMEPAGE="http://www.namazu.org/~satoru/pdumpfs/"
SRC_URI="http://www.namazu.org/~satoru/pdumpfs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc ~x86"
IUSE="cjk"

DEPEND=">=virtual/ruby-1.8.1"

src_compile() {
	emake pdumpfs || die "make pdumpfs failed"
}

src_test() {
	# RUBYOPT=-rauto_gem without rubygems installed will cause ruby to fail, bug #158455 and #163473.
	export RUBYOPT="${GENTOO_RUBYOPT}"
	emake check || die "make check failed"
}

src_install() {
	dobin pdumpfs || die

	doman man/man8/pdumpfs.8
	dohtml -r doc/*

	if use cjk; then
		insinto /usr/share/man/ja/man8
		doins man/ja/man8/pdumpfs.8
		dohtml pdumpfs-ja.html
	fi

	dodoc ChangeLog README
}
