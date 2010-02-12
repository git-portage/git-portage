# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/tsm/Attic/tsm-5.5.2.7.ebuild,v 1.3 2010/02/12 22:27:57 flameeyes Exp $

inherit versionator multilib eutils

DESCRIPTION="Tivoli Storage Manager (TSM) Backup/Archive (B/A) Client and API"
HOMEPAGE="http://www.tivoli.com/"

MY_PV_MAJOR=$(get_major_version)
MY_PV_MINOR=$(get_version_component_range 2)
MY_PV_TINY=$(get_version_component_range 3)

MY_PV_NODOTS="${MY_PV_MAJOR}${MY_PV_MINOR}${MY_PV_TINY}"
MY_PVR_ALLDOTS=${PV}

BASE_URI="ftp://ftp.software.ibm.com/storage/tivoli-storage-management/patches/client/v${MY_PV_MAJOR}r${MY_PV_MINOR}/Linux/LinuxX86/v${MY_PV_NODOTS}/"
SRC_TAR="${MY_PVR_ALLDOTS}-TIV-TSMBAC-LinuxX86.tar"
SRC_URI="${BASE_URI}${SRC_TAR}"

RESTRICT="strip" # Breaks libPiIMG.ss and libPiSNAP.so
LICENSE="as-is Apache-1.1 JDOM gSOAP"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="hsm"

DEPEND="app-arch/rpm2targz"
RDEPEND="sys-libs/libstdc++-v3"

S="${WORKDIR}"

pkg_setup() {
	enewgroup tsm
}

src_unpack() {
	unpack ${A}

	# Avoid "is setXid, dynamically linked and using lazy bindings" QA notices
	# (doesn't help, since they are binaries?)

	RPMS=("TIVsm-BA.i386.rpm" "TIVsm-API.i386.rpm")
	if use amd64 ; then
		RPMS=("${RPMS[@]}" "TIVsm-API64.rpm")
	fi
	if use hsm ; then
		RPMS=("${RPMS[@]}" "TIVsm-HSM.i386.rpm")
	fi

	for rpm in ${RPMS[@]}
	do
		einfo "Extracting: ${rpm}"
		rpm2tar -O ${rpm} | tar xfp -
	done

	# Avoid strange error messages caused by read-only files
	chmod -R u+w "${S}"
}

src_install() {
	cp -a opt "${D}"
	cp -a usr "${D}"

	chgrp -R tsm "${D}/opt/tivoli"
	fperms -R g+rX,o-rX /opt/tivoli # Allow only tsm group users to access TSM tools
	fperms 4710 /opt/tivoli/tsm/client/ba/bin/dsmtca

	keepdir /etc/tivoli

	cp -a "${S}/opt/tivoli/tsm/client/ba/bin/dsm.sys.smp" "${D}/etc/tivoli/dsm.sys"
	echo '	 PasswordDir "/etc/tivoli/"' >> ${D}/etc/tivoli/dsm.sys
	echo '	 PasswordAccess generate' >> ${D}/etc/tivoli/dsm.sys

	# Added the hostname to be more friendly, the admin will need to edit this file anyway
	echo '	 NodeName' `hostname` >> ${D}/etc/tivoli/dsm.sys
	echo '	 ErrorLogName "/var/log/dsmerror.log"' >> ${D}/etc/tivoli/dsm.sys
	echo '	 SchedLogName "/var/log/dsmsched.log"' >> ${D}/etc/tivoli/dsm.sys
	dosym ../../../../../../etc/tivoli/dsm.sys /opt/tivoli/tsm/client/ba/bin/dsm.sys

	cp -a "${S}/opt/tivoli/tsm/client/ba/bin/dsm.opt.smp" "${D}/etc/tivoli/dsm.opt"
	dosym ../../../../../../etc/tivoli/dsm.opt /opt/tivoli/tsm/client/ba/bin/dsm.opt

	# This creates the symlinks for the API libs
	dodir /usr/$(get_libdir)
	dosym ../../opt/tivoli/tsm/client/api/bin/libct_cu.so /usr/$(get_libdir)/libct_cu.so
	dosym ../../opt/tivoli/tsm/client/api/bin/libdmapi.so /usr/$(get_libdir)/libdmapi.so
	dosym ../../opt/tivoli/tsm/client/api/bin/libgpfs.so /usr/$(get_libdir)/libgpfs.so
	dosym ../../opt/tivoli/tsm/client/api/bin/libha_gs_r.so /usr/$(get_libdir)/libha_gs_r.so
	dosym ../../opt/tivoli/tsm/client/api/bin/libApiDS.so /usr/$(get_libdir)/libApiDS.so

	# Fix the client's inability to find dsmclientV3.cat
	dosym ../../lang/en_US /opt/tivoli/tsm/client/ba/bin/en_US

	# Setup the env
	dodir /etc/env.d
	ENV_FILE="${D}/etc/env.d/80tivoli"
	echo 'DSM_CONFIG="/etc/tivoli/dsm.opt"' >> ${ENV_FILE}
	echo 'DSM_DIR="/opt/tivoli/tsm/client/ba/bin"' >> ${ENV_FILE}
	echo 'DSM_LOG="/var/log"' >> ${ENV_FILE}
	echo 'PATH="/opt/tivoli/tsm/client/admin/bin:/opt/tivoli/tsm/client/ba/bin"' >> ${ENV_FILE}
	echo 'ROOTPATH="/opt/tivoli/tsm/client/admin/bin:/opt/tivoli/tsm/client/ba/bin"' >> ${ENV_FILE}

	newconfd "${FILESDIR}/dsmc.conf.d" dsmc
	newinitd "${FILESDIR}/dsmc.init.d" dsmc
	newinitd "${FILESDIR}/dsmcad.init.d" dsmcad

	elog
	elog "Note that you have to be either root or member of the group tsm to be able to use the"
	elog "Tivoli Storage Manager client."
	elog

}
