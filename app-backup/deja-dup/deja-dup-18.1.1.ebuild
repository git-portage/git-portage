# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/deja-dup/Attic/deja-dup-18.1.1.ebuild,v 1.3 2011/06/29 20:16:29 jlec Exp $

EAPI=3

inherit eutils gnome2

DESCRIPTION="Simple backup tool using duplicity back-end"
HOMEPAGE="https://launchpad.net/deja-dup/"
SRC_URI="http://launchpad.net/${PN}/18/${PV}/+download/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nautilus nls"

# TODO: need gnome-extra/indicator-application as a dep?
COMMON_DEPEND="
	>=dev-libs/glib-2.26:2
	>=x11-libs/gtk+-2.18:2
	>=x11-libs/libnotify-0.7.1

	app-backup/duplicity
	dev-libs/dbus-glib
	dev-libs/libunique:1
	gnome-base/gnome-keyring

	nautilus? ( gnome-base/nautilus )"
RDEPEND="${COMMON_DEPEND}
	gnome-base/gvfs[fuse]"
DEPEND="${COMMON_DEPEND}
	dev-perl/Locale-gettext
	dev-util/pkgconfig
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.17"
# Needed for eautoreconf:
# app-text/gnome-doc-utils

pkg_setup() {
	DOCS="NEWS AUTHORS"
	G2CONF="${G2CONF}
		$(use_enable nls)
		$(use_with nautilus)
		--without-appindicator
		--without-unity
		--without-gtk3
		--disable-maintainer-mode
		--disable-scrollkeeper
		--disable-schemas-compile"
	use nls && unset LINGUAS || export LINGUAS=""
}

src_install() {
	gnome2_src_install
	domenu data/deja-dup.desktop
}
