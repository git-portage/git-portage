# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Number-Format/Attic/Number-Format-1.60.ebuild,v 1.2 2008/12/31 18:35:24 tove Exp $

MODULE_AUTHOR=WRW
inherit perl-module

DESCRIPTION="Package for formatting numbers for display"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST="do"
