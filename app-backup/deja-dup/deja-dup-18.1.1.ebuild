# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/deja-dup/Attic/deja-dup-18.1.1.ebuild,v 1.1 2011/04/22 11:31:49 jlec Exp $

EAPI="3"

inherit eutils gnome2

DESCRIPTION="Simple backup tool using duplicity back-end"
HOMEPAGE="https://launchpad.net/deja-dup/"
SRC_URI="http://launchpad.net/${PN}/18/${PV}/+download/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nautilus nls"

# TODO: need gnome-extra/indicator-application as a dep?
DEPEND="
	app-backup/duplicity
	dev-libs/dbus-glib
	dev-libs/glib:2
	dev-libs/libunique
	gnome-base/gconf
	gnome-base/gnome-common
	gnome-base/gnome-keyring
	x11-libs/gtk+:2
	>=x11-libs/libnotify-0.7.1
	nautilus? ( gnome-base/nautilus )"
RDEPEND="${DEPEND}
	dev-lang/vala:0.12
	gnome-base/gvfs[fuse]"

DOCS="NEWS AUTHORS"

pkg_setup() {
	G2CONF="${G2CONF}
	$(use_enable nls)
	$(use_with nautilus)
	--without-appindicator
	--without-unity
	--without-gtk3
	--disable-scrollkeeper
	VALAC=$(type -P valac-0.12)"
	use nls && unset LINGUAS || export LINGUAS=""
}

src_install() {
	gnome2_src_install
	domenu data/deja-dup.desktop
}
