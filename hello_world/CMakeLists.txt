project(hello_world)

add_executable(hello_world
    src/unused.cpp
    src/main.asm
    src/stdlib.asm
)

target_include_directories(hello_world
    PRIVATE
        src
)

target_compile_definitions(hello_world
    PRIVATE
        UNICODE
        _UNICODE
)
