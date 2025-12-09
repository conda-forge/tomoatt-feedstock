#!/bin/bash

set -e

mkdir build && cd build

export LDFLAGS="${LDFLAGS} -L${PREFIX}/lib"
export CPPFLAGS="${CPPFLAGS} -I${PREFIX}/include"

# Set MPI compiler variables for CMake
if [ "$(uname)" == "Linux" ]; then
    export OMPI_CXX="${CXX}"
    export OMPI_CC="${CC}"
    
    # Use standard CMake variables for MPI
    # We do NOT set CMAKE_CXX_COMPILER to mpicxx because we want to use the conda compiler
    # Instead we let FindMPI use the wrappers to determine flags
    export MPI_CXX_COMPILER="$PREFIX/bin/mpicxx"
    export MPI_C_COMPILER="$PREFIX/bin/mpicc"
fi

cmake ${CMAKE_ARGS} \
      -D CMAKE_INSTALL_PREFIX=$PREFIX \
      ..
make -j$CPU_COUNT
make install

