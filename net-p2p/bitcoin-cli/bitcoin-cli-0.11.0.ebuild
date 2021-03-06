# Copyright 2010-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/bitcoin-cli/bitcoin-cli-0.11.0.ebuild,v 1.1 2015/07/17 22:16:07 blueness Exp $

EAPI=5

BITCOINCORE_COMMITHASH="d26f951802c762de04fb68e1a112d611929920ba"
BITCOINCORE_LJR_DATE="20150711"
BITCOINCORE_IUSE="ljr"
inherit bash-completion-r1 bitcoincore

DESCRIPTION="Command-line JSON-RPC client specifically designed for talking to Bitcoin Core Daemon"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86 ~amd64-linux ~x86-linux"

src_prepare() {
	sed -i 's/have bitcoind &&//;s/^\(complete -F _bitcoind \)bitcoind \(bitcoin-cli\)$/\1\2/' contrib/bitcoind.bash-completion
	bitcoincore_src_prepare
}

src_configure() {
	bitcoincore_conf \
		--enable-util-cli
}

src_install() {
	bitcoincore_src_install

	doman contrib/debian/manpages/bitcoin-cli.1

	newbashcomp contrib/bitcoind.bash-completion ${PN}
}
