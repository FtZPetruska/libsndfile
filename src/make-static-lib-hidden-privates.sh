#!/bin/bash -e

# This script takes a static library and removes all non-public symbols.
# Ie, it makes a static lib whose symbols are far less like;y to clash with
# the symbols of another shared or static library.

grep sf_ Symbols.linux | sed -e "s/[ ;]//g" > Symbols.static

ld -r --whole-archive .libs/libsndfile.a -o libsndfile_a.o

objcopy --keep-global-symbols=Symbols.static libsndfile_a.o libsndfile.o

rm -f libsndfile.a
ar cru libsndfile.a libsndfile.o
