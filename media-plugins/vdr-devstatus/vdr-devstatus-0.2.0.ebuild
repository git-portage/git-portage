# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-devstatus/Attic/vdr-devstatus-0.2.0.ebuild,v 1.2 2009/02/15 18:48:24 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR plugin: displays the usage status of the available devices."
HOMEPAGE="http://www.u32.de/vdr.html"
SRC_URI="mirror://gentoo/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.4.7"

RDEPEND="${DEPEND}"
