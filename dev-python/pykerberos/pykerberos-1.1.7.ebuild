# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pykerberos/pykerberos-1.1.7.ebuild,v 1.2 2015/06/30 02:19:37 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="A high-level Python wrapper for Kerberos/GSSAPI operations"
HOMEPAGE="http://trac.calendarserver.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}-1.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

DEPEND="app-crypt/mit-krb5
		dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
