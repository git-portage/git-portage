# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Francisco Gimeno <kikov@fco-gimeno.com>
# Mantainer: José Alberto Suárez López <bass@gentoo.org>

DESCRIPTION="Gtk 2.0 EBook." 

EBOOKNAME="gtk"
EBOOKVERSION="2.0"

SRC_URI="http://lidn.sourceforge.net/books_download/${EBOOKNAME}-${EBOOKVERSION}.tar.gz"
HOMEPAGE="http://lidn.sourceforge.net/"

RDEPEND=">=dev-util/devhelp-0.3"

DEVHELPROOT="usr/share/devhelp"
src_unpack() {
  unpack ${A}
}

S=${WORKDIR}/${EBOOKNAME}-${EBOOKVERSION}

src_install () {
   dodir ${DEVHELPROOT}/specs
   dodir ${DEVHELPROOT}/books
   dodir ${DEVHELPROOT}/books/${EBOOKNAME}-${EBOOKVERSION}
   cp ${S}/book.devhelp ${D}${DEVHELPROOT}/specs/${EBOOKNAME}-${EBOOKVERSION}
   cp -R ${S}/book/* ${D}${DEVHELPROOT}/books/${EBOOKNAME}-${EBOOKVERSION}/
}


