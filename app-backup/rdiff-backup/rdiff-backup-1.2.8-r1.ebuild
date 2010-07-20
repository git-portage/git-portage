# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/rdiff-backup/rdiff-backup-1.2.8-r1.ebuild,v 1.1 2010/07/20 16:25:08 robbat2 Exp $

EAPI="3"
inherit distutils eutils

DESCRIPTION="Remote incremental file backup utility; uses librsync's rdiff utility to create concise, versioned backups."
HOMEPAGE="http://www.nongnu.org/rdiff-backup/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="acl xattr"

DEPEND=">=net-libs/librsync-0.9.7
		!arm? ( xattr? ( dev-python/pyxattr )
				acl? ( dev-python/pylibacl ) )"
RDEPEND="${DEPEND}"

DOCS="examples.html"

src_prepare() {
	epatch "${FILESDIR}"/rdiff-backup-1.2.8-popen2.patch
}
