#!/bin/bash

set -e

mkdir build && cd build

export LDFLAGS="${LDFLAGS} -L${PREFIX}/lib"
export CPPFLAGS="${CPPFLAGS} -I${PREFIX}/include"

# Use MPI wrappers
if [ "$(uname)" == "Linux" ]; then
    export OMPI_CXX="${CXX}"
    export OMPI_CC="${CC}"
    export CXX=mpicxx
    export CC=mpicc
fi

cmake ${CMAKE_ARGS} -D CMAKE_INSTALL_PREFIX=$PREFIX ..
make -j$CPU_COUNT
make install

