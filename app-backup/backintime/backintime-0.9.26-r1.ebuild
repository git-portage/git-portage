# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/backintime/Attic/backintime-0.9.26-r1.ebuild,v 1.4 2010/01/13 08:41:22 bangert Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A simple backup system inspired by TimeVault and FlyBack, with a GUI for GNOME and KDE4"
HOMEPAGE="http://backintime.le-web.org/"
SRC_URI="http://backintime.le-web.org/download/backintime/${P}_src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="kde gnome"

DEPEND="dev-lang/python
	net-misc/rsync[xattr]
	kde? (
		>=kde-base/kdelibs-4
		kde-base/pykde4
		kde-base/kompare
		kde-base/kdesu
		)
	gnome? (
		gnome-base/libglade
		gnome-base/gnome-session
		dev-python/gnome-vfs-python
		dev-python/gnome-python
		)
	dev-python/notify-python
	"

RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/backintime-0.9.26-information-disclosure.diff
	epatch "${FILESDIR}"/backintime-0.9.26-dont-install-license.diff
	#fix doc install location
	sed -i "s:/doc/kde4/HTML/:/doc/HTML/:g" kde4/Makefile.template
	sed -i "s:/doc/backintime:/doc/${P}:g" common/Makefile.template
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
		#use kdesu instead of kdesudo
		sed -i 's/kdesudo/kdesu/' \
			"${D}"//usr/share/applications/kde4/backintime-kde4-root.desktop
	fi

	if use gnome ; then
		cd "${S}"/gnome
		emake DESTDIR="${D}" install || die
	fi
}
