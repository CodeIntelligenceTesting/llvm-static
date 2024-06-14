# LLVM Tooling

This repository contains scripts to build static LLVM libraries which can be
used to develop libclangTooling based tools. See the release page for
downloadable archives.

## Usage

The uploaded archive contains a `CMakeLists.txt` which allows for quick
integration of the LLVM tooling libraries in a CMake project. Add the following
snippet to your `CMakeLists.txt` to download the LLVM libraries and link a
target against them:

```
FetchContent_Declare(LLVM URL "https://github.com/CodeIntelligenceTesting/llvm-static/releases/download/18.1.5-b1/llvm-static-linux-amd64.tar.xz")
FetchContent_MakeAvailable(LLVM)

target_link_libraries(<TARGET> PRIVATE clangTooling)
```

## Create New Release

To create a new release e.g. for a new version of LLVM, update the
`CMakeLists.txt` and trigger the manual workflow
["Build LLVM"](https://github.com/CodeIntelligenceTesting/llvm-static/actions/workflows/build-llvm.yaml).
