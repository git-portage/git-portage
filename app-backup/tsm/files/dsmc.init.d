#!/sbin/runscript
# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/tsm/files/dsmc.init.d,v 1.3 2012/02/12 11:56:50 dilfridge Exp $

depend() {
        use net
        after dns
}

start() {
        ebegin "Starting dsmc"
	# dsmc supports only these locale settings
	export LANG=en_US
	export LC_ALL=en_US

        start-stop-daemon --start --background --nicelevel 15 \
                --make-pidfile --pidfile /var/run/dsmc.pid \
                --exec /opt/tivoli/tsm/client/ba/bin/dsmc sched ${DSMC_OPTS}
        eend $?
}

stop() {
        ebegin "Stopping dsmc"
        # For whatever reason SIGTERM doesn't affect the dsmc process, but
        # SIGHUP makes it exit cleanly
        start-stop-daemon --stop \
                --signal 1 \
                --pidfile /var/run/dsmc.pid
        eend $?
}

