#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
BUILD_DIR="$SCRIPT_DIR/build"
LLVM_BUILD_DIR="$BUILD_DIR/external.llvm-project"

OUTPUT_FILE=llvm-static-libs.tar.xz
if [ "$#" -eq 1 ]
then
  OUTPUT_FILE=$1
fi

CC=clang
CXX=clang++

ARCH=$(uname -m)

if [ "$ARCH" == "x86_64" ]; then
  TARGET_PLATFORM=X86
elif [ "$ARCH" == "arm64" ] || [ "$ARCH" == "aarch64" ]; then
  TARGET_PLATFORM=AArch64
else
  echo "Unsupported architecture: $ARCH"
  exit 1
fi

cd "$SCRIPT_DIR"
mkdir -p $BUILD_DIR

cmake -B build -GNinja -DLLVM_TARGETS_TO_BUILD=${TARGET_PLATFORM} .
cmake --build build

# Pack everything we need into a tar archive.
# We only need the header files, static libraries and add
# a CMake file that makes it easy to link libclangTooling.
cp $SCRIPT_DIR/cmake/CMakeLists.txt $LLVM_BUILD_DIR
cd $LLVM_BUILD_DIR
tar -czvf "$SCRIPT_DIR/$OUTPUT_FILE" include/ lib/*.a CMakeLists.txt
