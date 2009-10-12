# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/afbackup-client/Attic/afbackup-client-3.3.8.1.ebuild,v 1.3 2009/10/12 17:11:29 halcy0n Exp $

inherit eutils

# is this the server ebuild, otherwise client
if [ "${PN/afbackup-/}" = "server" ];then
MY_PN=${PN/-server/}
MY_MODE=server
else
MY_PN=${PN/-client/}
MY_MODE=client
fi
MY_P=${MY_PN}-${PV}

DESCRIPTION="AFBackup is a client/server backup tool"
HOMEPAGE="http://afbackup.sourceforge.net/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="zlib"

DEPEND="zlib? ( sys-libs/zlib )"
RDEPEND="zlib? ( sys-libs/zlib )"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e 's:subdir="/backup":subdir="/afbackup":' configure

	# Setting up authentication key
	einfo "Searching for your afbackup.key..."
	if [ -f /etc/afbackup/afbackup.key ]; then
	AFBACKUPKEY=`echo /etc/afbackup/afbackup.key`
	einfo "...found."
	fi

	# if none, generate a random key
	if [ "x${AFBACKUPKEY}" = "x" ]; then
	ewarn "AFBACKUPKEY environment variable not set, generating new key..."
	AFBACKUPKEY=`head -c4 /dev/urandom | od -N4 -tu4 | sed -ne '1s/.* //p'`
	fi

	einfo "Using ${AFBACKUPKEY} as your backup key."
	sed -i -e "s:k=\" \":k=\"${AFBACKUPKEY}\":" ask_for_key
	echo ${AFBACKUPKEY} > ${S}/afbackup.key
}

src_compile() {
	local myconf=""
	use zlib && myconf="${myconf} --with-zlib"
	./configure \
		--host=${CHOST} \
		--prefix=/opt \
		--with-serverconfdir=/etc/afbackup \
		--with-serverconf=server.conf \
		--with-servermandir=/usr/share/man \
		--with-clientconfdir=/etc/afbackup \
		--with-clientconf=client.conf \
		--with-clientmandir=/usr/share/man \
		--mandir=/usr/share/man \
		${myconf} || die "./configure failed"

	einfo "Building: afbackup-${MY_MODE}"
	emake ${MY_MODE} || die "emake failed"
}

src_install() {
	local myconf=""
	use zlib && myconf="${myconf} --with-zlib"
	einfo "Reconfiguring ${MY_MODE} installation path..."
	./configure \
		--host=${CHOST} \
		--prefix="${D}"/opt \
		--with-serverconfdir="${D}"/etc/afbackup \
		--with-serverconf=server.conf \
		--with-servermandir="${D}"/usr/share/man \
		--with-clientconfdir="${D}"/etc/afbackup \
		--with-clientconf=client.conf \
		--with-clientmandir="${D}"/usr/share/man \
		--mandir="${D}"/usr/share/man \
		${myconf} || die "./configure failed"

	einfo "Installing: afbackup-${MY_MODE}"
	make DESTDIR=${D} install.${MY_MODE} || die

	# fix path in config files
	einfo "Fixing paths in ${MY_MODE}.conf"
	if [ "x${MY_MODE}" = "xserver" ]; then
	sed -i -e "s:${D}::g" "${D}"/etc/afbackup/server.conf
	fi
	if [ "x${MY_MODE}" = "xclient" ]; then
	sed -i -e "s:${D}::g" "${D}"/etc/afbackup/client.conf
	fi

	# if new, install key and set permissions
	if [ ! -f /etc/afbackup/afbackup.key ]; then
	einfo "Installing backup key..."
	insinto /etc/afbackup
	doins afbackup.key
	einfo "Restricting permissions on keyfile..."
	fperms 600 /etc/afbackup/afbackup.key
	fi
}

pkg_postinst() {
	elog "The key of afbackup server and client have to match."
	elog "Be sure to use the same environment variable or keyfile."
}
