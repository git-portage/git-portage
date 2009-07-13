# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/bobs/Attic/bobs-0.6.2-r1.ebuild,v 1.5 2009/07/13 00:39:32 flameeyes Exp $

inherit webapp eutils autotools

DESCRIPTION="The Browsable Online Backup System"
HOMEPAGE="http://bobs.sourceforge.net/"

SRC_URI="mirror://sourceforge/bobs/${P}.tar.gz"

LICENSE="GPL-2"

KEYWORDS="~x86 ~ppc"

IUSE=""

DEPEND="virtual/php"

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/bobs-0.6.2.patch

	#Makefile was executing commands out of the sandbox (bug #133409)
	epatch ${FILESDIR}/Makefile-fixcmdloopd.patch

	# Original configure looks for httpd process.  Hardwire to apache2...
	sed -e "s:\$(ps -C httpd:\$(ps -C apache2:" \
		-i 'configure' || die "Autodetect of Apache user failed"
	# Slightly nasty fixup for some problems in the orig Makefile
	# Otherwise it doesn't respect that prefix given to "make install"
	sed -e "s:\$(myBOBSDATA):\$(DESTDIR)\$(myBOBSDATA):" \
		-i 'Makefile.am' || die "Makefile bodge 1 failed"
	sed -e "s:\$(top_srcdir)/mkinstalldirs \$(myWEBDIR):\$(top_srcdir)/mkinstalldirs \$(DESTDIR)\$(myWEBDIR):" \
		-i 'inc/servers/Makefile.am' || die "Makefile bodge 2 failed"
	sed	-e "s:chown -R \$(myHTTPDUSER) \$(myWEBDIR):chown -R \$(myHTTPDUSER) \$(DESTDIR)\$(myWEBDIR):" \
		-i 'inc/servers/Makefile.am' || die "Makefile bodge failed"
	# Modify the webdir to match the webapp format
	sed -e "s:myWEBDIR=\$with_webdir/bobs:myWEBDIR=\$with_webdir:" \
		-i 'configure' || die "configure bodge failed"

	eautoreconf
}

src_compile() {
	econf \
		--with-webdir=/usr/share/webapps/${PN}/${PVR}/htdocs \
		|| die "configure failed"

	emake || die "emake failed"
}

src_install() {
	webapp_src_preinst
#	MY_HTDOCSDIR="/usr/share/webapps/${PN}/${PVR}"
	if [[ ! `built_with_use virtual/php posix` ]]; then
	  ewarn "Your PHP does not appear to support POSIX functions. ${P} requires"
	  ewarn "POSIX functions to be enabled.  I will continue to install ${P} but"
	  ewarn "You need to recompile PHP with POSIX support by recompiling"
	  ewarn "with the 'posix' USE flag enabled for php. See bug #133198."
	  ebeep 5
	fi

	make DESTDIR="${D}" install || die
	keepdir /var/bobsdata/current/process/session
	keepdir /var/bobsdata/current/process/cmd
	keepdir /var/bobsdata/current/process/mounts
	webapp_configfile "${MY_HTDOCSDIR}"/inc/excludes/default.excludelist
	webapp_configfile "${MY_HTDOCSDIR}"/inc/config.php
	webapp_configfile "${MY_HTDOCSDIR}"/inc/servers/testserver.share.ini

	dodir /var/bobsdata/incoming
	dodir /var/bobsdata/incremental

	# Why doesn't this next line work?
	chown -R root:apache "${D}"/var/bobsdata/
	elog "/var/bobsdata MUST be accessible to the apache user"

	dodoc README INSTALL TODO

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt

	webapp_src_install
	elog "Add /etc/init.d/cmdloopd to default runlevel"
}
