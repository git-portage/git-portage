# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/backupninja/Attic/backupninja-0.9.9.ebuild,v 1.2 2011/07/19 08:22:49 hwoarang Exp $

EAPI=4

inherit autotools

# This thing change with every release, how idiotic...
NODE_NUMBER=230

DESCRIPTION="lightweight, extensible meta-backup system"
HOMEPAGE="http://riseuplabs.org/backupninja/"
SRC_URI="https://labs.riseup.net/code/attachments/download/${NODE_NUMBER}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="dev-util/dialog"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS FAQ TODO README NEWS )

src_prepare() {
	eautoreconf
}
