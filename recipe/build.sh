#!/bin/bash

set -e

mkdir build && cd build

export LDFLAGS="${LDFLAGS} -L${PREFIX}/lib"
export CPPFLAGS="${CPPFLAGS} -I${PREFIX}/include"


cmake ${CMAKE_ARGS} \
      -D CMAKE_INSTALL_PREFIX=$PREFIX \
      -D CMAKE_PREFIX_PATH=$PREFIX \
      ..
make -j$CPU_COUNT
make install

