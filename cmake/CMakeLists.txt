# Static libraries that are needed when using libclangTooling
set(CLANG_TOOLING_DEPS
    clangFormat
    clangToolingInclusions
    clangFrontend
    clangDriver
    clangParse
    clangSerialization
    clangSema
    clangAPINotes
    clangEdit
    clangAnalysis
    clangASTMatchers
    clangAST
    clangSupport
    clangToolingCore
    clangRewrite
    clangLex
    clangBasic
    # Order as reported by llvm-config --libs --link-static
    LLVMWindowsDriver
    LLVMOption
    LLVMFrontendOpenMP
    LLVMFrontendOffloading
    LLVMScalarOpts
    LLVMTransformUtils
    LLVMAnalysis
    LLVMProfileData
    LLVMDebugInfoDWARF
    LLVMObject
    LLVMTextAPI
    LLVMMCParser
    LLVMIRReader
    LLVMAsmParser
    LLVMMC
    LLVMBitReader
    LLVMCore
    LLVMRemarks
    LLVMBitstreamReader
    LLVMBinaryFormat
    LLVMTargetParser
    LLVMSupport
    LLVMDemangle)

foreach(lib ${CLANG_TOOLING_DEPS})
    add_library(${lib} STATIC IMPORTED)
    set_property(TARGET ${lib} PROPERTY IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/lib/lib${lib}.a")
endforeach(lib)

# Exported clangTooling target.
add_library(clangTooling STATIC IMPORTED GLOBAL)
set_property(TARGET clangTooling PROPERTY IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/lib/libclangTooling.a")
target_include_directories(clangTooling INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/include)
set_target_properties(clangTooling PROPERTIES INTERFACE_LINK_LIBRARIES "${CLANG_TOOLING_DEPS};pthread;${CMAKE_DL_LIBS}")
