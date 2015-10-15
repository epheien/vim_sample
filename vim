#!/bin/bash

# 几个有用的变量
__file__=$(readlink -f "$0")
__name__=$(basename "$__file__")
__dir__=$(dirname "$__file__")

/usr/bin/vim -u "$__dir__/dotvimrc" "$@"

# vi:set et sts=4 sw=4 ts=8:
