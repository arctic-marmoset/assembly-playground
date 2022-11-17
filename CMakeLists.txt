cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(Playground C CXX ASM_NASM)

set(CMAKE_C_STANDARD           17)
set(CMAKE_C_STANDARD_REQUIRED  ON)
set(CMAKE_C_EXTENSIONS        OFF)

set(CMAKE_CXX_STANDARD           23)
set(CMAKE_CXX_STANDARD_REQUIRED  ON)
set(CMAKE_CXX_EXTENSIONS        OFF)

set(CMAKE_ASM_NASM_FLAGS_DEBUG          "-w+all -g -Ox")
set(CMAKE_ASM_NASM_FLAGS_RELEASE        "-w+all    -Ox")
set(CMAKE_ASM_NASM_FLAGS_RELWITHDEBINFO "-w+all -g -Ox")
set(CMAKE_ASM_NASM_FLAGS_MINSIZEREL     "-w+all    -Ox")

include(CheckIPOSupported)
check_ipo_supported()

add_executable(Playground
    src/unused.cpp
    src/main.asm
    src/stdlib.asm
)

target_include_directories(Playground
    PRIVATE
        src
)

target_compile_definitions(Playground
    PRIVATE
        UNICODE
        _UNICODE
)

if(CMAKE_BUILD_TYPE MATCHES "Release" OR CMAKE_BUILD_TYPE MATCHES "RelWithDebInfo")
    set_property(TARGET Playground PROPERTY INTERPROCEDURAL_OPTIMIZATION TRUE)
endif()
