#!/bin/bash

set -e

# Create pkg-config aliases for MPI if they don't exist
if [ -f $PREFIX/lib/pkgconfig/ompi-c.pc ] && [ ! -f $PREFIX/lib/pkgconfig/mpi-c.pc ]; then
    ln -s $PREFIX/lib/pkgconfig/ompi-c.pc $PREFIX/lib/pkgconfig/mpi-c.pc
fi
if [ -f $PREFIX/lib/pkgconfig/ompi-cxx.pc ] && [ ! -f $PREFIX/lib/pkgconfig/mpi-cxx.pc ]; then
    ln -s $PREFIX/lib/pkgconfig/ompi-cxx.pc $PREFIX/lib/pkgconfig/mpi-cxx.pc
fi

mkdir build && cd build

export LDFLAGS="${LDFLAGS} -L${PREFIX}/lib"
export CPPFLAGS="${CPPFLAGS} -I${PREFIX}/include"


cmake ${CMAKE_ARGS} \
      -D CMAKE_INSTALL_PREFIX=$PREFIX \
      -D CMAKE_PREFIX_PATH=$PREFIX \
      ..
make -j$CPU_COUNT
make install

