#!/usr/bin/env sh

# Use this script to bootstrap your build AFTER checking it out from
# source control. You should not have to use it for anything else.
echo "Regenerating autotools files"
case `uname` in
    Darwin) libtoolize=glibtoolize ;;
    *)      libtoolize=libtoolize  ;;
esac

set -x
$libtoolize --force --automake --copy
aclocal -I build/acmacros
automake --foreign --add-missing --copy
autoconf

rm -rf autom4te.cache
echo "Now run ./configure, make, and make install."
