#!/bin/env bash

ver=$(php -r "echo implode('.', array_slice(explode('.', PHP_VERSION),0,2));")

xdb=""

echo $ver

case "$ver" in
    "7.4" | "7.3" | "7.2")
        xdb="xdebug-3.1.6"
        ;;
    "7.1")
        xdb="xdebug-2.9.8"
        ;;
    "7.0")
        xdb="xdebug-2.7.2"
        ;;
    "5.6" | "5.5")
        xdb="xdebug-2.5.5"
        ;;
    "5.4")
        xdb="xdebug-2.4.1"
        ;;
    "5.3")
        xdb="xdebug-2.2.7"
        ;;
    *)
        xdb="xdebug"
        ;;
esac

echo $xdb
    
pecl install $xdb 