#!/bin/bash

# This script must be run under the directory it exists. Run this script after
# you download the PHP source code from php.net and extract the source code to
# dist directory.

WORK_DIR=`pwd`

mkdir -p ${WORK_DIR}/tmp

cd ${WORK_DIR}/tmp

wget http://pecl.php.net/get/oauth-1.2.3.tgz
wget http://pecl.php.net/get/memcache-2.2.7.tgz
wget http://pecl.php.net/get/APC-3.1.9.tgz
wget http://pecl.php.net/get/imagick-3.0.1.tgz
wget http://pecl.php.net/get/proctitle-0.1.2.tgz
wget http://pecl.php.net/get/ncurses-1.0.2.tgz

for i in *tgz; do
    tar xzf $i
done

ls -1 | grep -E ".*-([[:digit:]]+\.+){2}" | grep -v tgz | while read i; do
    mv $i `echo $i | cut -d\- -f 1`
done

mv APC apc

find . -maxdepth 1 -type d ! -path . -exec mv -v {} ../dist/ext ';'

cd ${WORK_DIR} && rm -rvf tmp
