#!/sbin/runscript
# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/tsm/files/dsmcad.init.d,v 1.1 2010/01/27 16:47:11 dertobi123 Exp $

depend() {
        use net
        after dns dsmc
}

start() {
        ebegin "Starting dsmcad"
        start-stop-daemon --start --background --nicelevel 15 \
                --make-pidfile --pidfile /var/run/dsmcad.pid \
                --exec /opt/tivoli/tsm/client/ba/bin/dsmcad
        eend $?
}

stop() {
        ebegin "Stopping dsmcad"
        start-stop-daemon --stop \
                --signal 1 \
                --pidfile /var/run/dsmcad.pid
        eend $?
}
