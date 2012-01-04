# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/deja-dup/Attic/deja-dup-21.2.ebuild,v 1.2 2012/01/04 17:39:43 jlec Exp $

EAPI=4

inherit autotools eutils gnome2

DESCRIPTION="Simple backup tool using duplicity back-end"
HOMEPAGE="https://launchpad.net/deja-dup/"
SRC_URI="http://launchpad.net/${PN}/22/${PV}/+download/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nautilus nls"

COMMON_DEPEND="
	>=dev-libs/glib-2.26:2
	x11-libs/gtk+:2
	>=x11-libs/libnotify-0.7.1

	app-backup/duplicity
	dev-libs/dbus-glib
	dev-libs/libunique:1
	gnome-base/gnome-keyring

	nautilus? ( gnome-base/nautilus )"
RDEPEND="${COMMON_DEPEND}
	gnome-base/gvfs[fuse]"
DEPEND="${COMMON_DEPEND}
	app-text/yelp-tools
	dev-lang/vala:0.14
	dev-perl/Locale-gettext
	dev-util/pkgconfig
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17"

pkg_setup() {
	DOCS="NEWS AUTHORS"
	G2CONF="${G2CONF}
		$(use_enable nls)
		$(use_with nautilus)
		--without-ccpanel
		--without-unity
		--disable-schemas-compile"
	use nls && unset LINGUAS || export LINGUAS=""
	export VALAC=$(type -p valac-0.14)
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-prll.patch \
		"${FILESDIR}"/${P}-test.patch
	eautoreconf
	gnome2_src_prepare
}

src_install() {
	gnome2_src_install
	domenu data/deja-dup.desktop
}
