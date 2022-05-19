cmake_minimum_required(VERSION 3.16)
project(Compiler)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(LLVM REQUIRED CONFIG)
find_package(jsoncpp REQUIRED)

include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})
add_executable(Compiler src/Emit.cpp src/Emit.h src/treenode.cpp src/treenode.h src/main.cpp src/parsing.cpp src/parsing.hpp src/lex.yy.cc)
set(LLVM_LINK_COMPONENTS
    Core
    ExecutionEngine
    Interpreter
    MC
    Support
    nativecodegen
    mcjit
    asmparser
    x86asmparser
)
llvm_map_components_to_libnames(llvm_libs ${LLVM_LINK_COMPONENTS})
target_link_libraries(Compiler ${llvm_libs} jsoncpp_lib)
#explicit_llvm_config(Compiler core support engine interpreter executionengine mcjit orcjit)
