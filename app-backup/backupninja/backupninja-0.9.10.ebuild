# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/backupninja/Attic/backupninja-0.9.10.ebuild,v 1.1 2012/02/22 16:55:25 phajdan.jr Exp $

EAPI=4

inherit autotools

# This thing change with every release, how idiotic...
NODE_NUMBER=242

DESCRIPTION="lightweight, extensible meta-backup system"
HOMEPAGE="http://riseuplabs.org/backupninja/"
SRC_URI="https://labs.riseup.net/code/attachments/download/${NODE_NUMBER}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-util/dialog"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS FAQ TODO README NEWS )

src_prepare() {
	eautoreconf
}
