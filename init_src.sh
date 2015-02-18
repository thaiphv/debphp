#!/bin/bash

set -o errexit

function extract_php_extension() {
    INPUT="http://pecl.php.net/get/$1.tgz"
    OUTPUT="dist/ext/${1%-*}"

    rm -rf "$OUTPUT"
    mkdir "$OUTPUT"
    wget -O- "$INPUT" | tar --strip-components 1 -zx -C "$OUTPUT"
}

rm -rf dist/
mkdir dist/
wget -O- https://github.com/php/php-src/archive/php-5.3.29.tar.gz | tar --strip-components 1 -zx -C dist
wget http://pear.php.net/install-pear-nozlib.phar -P dist/pear/

extract_php_extension oauth-1.2.3
extract_php_extension memcache-2.2.7
extract_php_extension proctitle-0.1.2
extract_php_extension ncurses-1.0.2

pushd dist
PHP_AUTOCONF=autoconf2.59 ./buildconf --force
./configure
./genfiles
popd

find patches -type f -name "*.patch" -exec patch -p0 -i {} \;
