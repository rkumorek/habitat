#!/bin/sh

fd --color never -d 1 -- "^$1" "$2" 2> /dev/null | cut "-c$3-"
