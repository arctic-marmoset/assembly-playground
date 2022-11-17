cmake_minimum_required(VERSION 3.22 FATAL_ERROR)
project(Playground CXX ASM_NASM)

set(CMAKE_CXX_STANDARD           23)
set(CMAKE_CXX_STANDARD_REQUIRED  ON)
set(CMAKE_CXX_EXTENSIONS        OFF)

set(CMAKE_ASM_NASM_FLAGS_DEBUG          "-w+all -g -Ox")
set(CMAKE_ASM_NASM_FLAGS_RELEASE        "-w+all    -Ox")
set(CMAKE_ASM_NASM_FLAGS_RELWITHDEBINFO "-w+all -g -Ox")
set(CMAKE_ASM_NASM_FLAGS_MINSIZEREL     "-w+all    -Ox")

add_subdirectory(hello_world)
add_subdirectory(hello_window)
