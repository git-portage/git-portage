#!/bin/sh


C_NORMAL=$'\033[0m'
C_HILITE=$'\e[36;01m'
C_END=$'\e[A\e[73G'
C_OK=$'\e[32m'
C_NO=$'\e[31m'
PORTDIR=/portage

if [ -z "${ROOT}" ]
then
	echo "ROOT not set !"
	exit 1
fi

if [ -n "`ls ${ROOT}`" ]
then
  echo "$C_HILITE>>>$C_NORMAL Cleaning ${ROOT}..."
  rm -r ${ROOT}/*
fi

echo "$C_HILITE>>>$C_NORMAL Reading configuration..."
mylist=${PORTDIR}/gentoo-x86/current-packages

if [ -f "${1}" ]
then
  mylist=${1}
fi

echo "$C_HILITE>>>$C_NORMAL Using ${mylist}"

mypackages="`grep -v "\#.*" $mylist`"

if [ -d "/tmp/portage-log" ]
then
  rm -r /tmp/portage-log
fi

mkdir /tmp/portage-log

echo "$C_HILITE>>>$C_NORMAL Building ..."
for i in $mypackages
do

  # full path
  myd=${i/.\//$PORTDIR\/gentoo-x86\/}

  # file name
  myf="`basename $myd`"

  # category
  myc="`echo $i | sed -e "s:^\./\(.*\).*/.*/.*$:\1:"`"

  # package name
  myp=${myf%*.ebuild}

  if [ -f "$myd" ]
  then
    echo "$C_NORMAL $myp ($myc)"

    myl="/tmp/portage-log/$myc/$myp/"
    install -d $myl 

    # Check dependencies
    echo "$C_END $C_HILITE [CHECK]  "
    ebuild $myd check &> $myl/check
    mye=$?
    if [ $mye -ne 0 ]
    then
      echo "$C_END $C_NO [CHECK]  "
      echo $myd > /tmp/portage/check-failed
      continue
    fi
       
    # Clean
    echo "$C_END $C_HILITE [CLEAN]  "
    ebuild $myd clean &> $myl/clean
    mye=$?
    if [ $mye -ne 0 ]
    then
      echo "$C_END $C_NO [CLEAN]  "
      echo $myd > /tmp/portage/clean-failed
      continue
    fi

    # Unpack
    echo "$C_END $C_HILITE [UNPACK] "
    ebuild $myd unpack &> $myl/unpack
    mye=$?
    if [ $mye -ne 0 ]
    then
      echo "$C_END $C_NO [UNPACK] "
      echo $myd > /tmp/portage/unpack-failed
      continue
    fi

    # Compile
    echo "$C_END $C_HILITE [COMPILE]"
    ebuild $myd compile &> $myl/compile
    mye=$?
    if [ $mye -ne 0 ]
    then
      echo "$C_END $C_NO [COMPILE]"
      echo $myd > /tmp/portage/compile-failed
      continue
    fi

    # Install
    echo "$C_END $C_HILITE [INSTALL]"
    ebuild $myd install &> $myl/install
    mye=$?
    if [ $mye -ne 0 ]
    then
      echo "$C_END $C_NO [INSTALL]"
      echo $myd > /tmp/portage/install-failed
      continue
    fi

    # Merge
    echo "$C_END $C_HILITE [MERGE]  "
    ebuild $myd qmerge &> $myl/merge
    mye=$?
    if [ $mye -ne 0 ]
    then
      echo "$C_END $C_NO [MERGE]  "
      echo $myd > /tmp/portage/merge-failed
      continue
    fi

    echo "$C_END $C_OK [OK]     "

  else
    echo "!!! $myd does not exists !"
  fi
done
