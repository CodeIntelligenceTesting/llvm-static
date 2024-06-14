#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
BUILD_DIR="$SCRIPT_DIR/build"
LLVM_BUILD_DIR="$BUILD_DIR/external.llvm-project"

cd "$SCRIPT_DIR"
mkdir -p build
cmake -B build -GNinja .
cmake --build build

# Pack everything we need into a tar archive.
# We only need the header files, static libraries and add
# a CMake file that makes it easy to link libclangTooling.
cp $SCRIPT_DIR/cmake/CMakeLists.txt $LLVM_BUILD_DIR
cd $LLVM_BUILD_DIR
tar -czvf "$SCRIPT_DIR/llvm-static-libs.tar.xz" include/ lib/*.a CMakeLists.txt
