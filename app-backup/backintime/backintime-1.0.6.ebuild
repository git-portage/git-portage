# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/backintime/Attic/backintime-1.0.6.ebuild,v 1.1 2011/02/01 11:03:35 bangert Exp $

EAPI="3"

inherit eutils

DESCRIPTION="A simple backup system inspired by TimeVault and FlyBack, with a GUI for GNOME and KDE4"
HOMEPAGE="http://backintime.le-web.org/"
SRC_URI="http://backintime.le-web.org/download/${PN}/${P}_src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="kde gnome"

DEPEND="dev-lang/python
	net-misc/rsync[xattr,acl]
	kde? (
		>=kde-base/kdelibs-4
		kde-base/pykde4
		kde-base/kompare
		kde-base/kdesu
		)
	gnome? (
		gnome-base/libglade
		dev-util/meld
		gnome-base/gnome-session
		dev-python/gnome-vfs-python
		dev-python/libgnome-python
		dev-python/pygobject
		dev-python/pygtk
		)
	dev-python/notify-python
	"

RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.0.4-dont-install-license.diff
	epatch "${FILESDIR}"/${PN}-1.0.4-fix-configure-warning.diff
	#fix doc install location
	sed -i "s:/doc/kde4/HTML/:/doc/HTML/:g" kde4/Makefile.template
	sed -i "s:/doc/backintime:/doc/${PF}:g" common/Makefile.template

	cp "${FILESDIR}"/backintime-1.0.4-kde4-root.desktop \
		"${S}"/kde4/backintime-kde4-root.desktop
}

src_configure() {
	cd "${S}"/common
	econf

	if use kde ; then
		cd "${S}"/kde4
		econf
	fi

	if use gnome ; then
		cd "${S}"/gnome
		econf
	fi
}

src_compile() {
	cd "${S}"/common
	emake

	if use kde ; then
		cd "${S}"/kde4
		emake
	fi

	if use gnome ; then
		cd "${S}"/gnome
		emake
	fi
}

src_install() {
	cd "${S}"/common
	emake DESTDIR="${D}" install || die

	if use kde ; then
		cd "${S}"/kde4
		emake DESTDIR="${D}" install || die
	fi

	if use gnome ; then
		cd "${S}"/gnome
		emake DESTDIR="${D}" install || die
	fi
}
