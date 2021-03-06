# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Config-General/Config-General-2.560.0.ebuild,v 1.1 2015/04/01 22:31:38 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=TLINDEN
MODULE_VERSION=2.56
inherit perl-module

DESCRIPTION="Config file parser module"

SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	virtual/perl-File-Spec
	virtual/perl-IO
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"

SRC_TEST="do"
