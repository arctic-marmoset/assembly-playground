project(hello_window)

add_executable(hello_window WIN32
    src/Unused.cpp
    src/Main.asm
)

target_include_directories(hello_window
    PRIVATE
        src
)

target_compile_definitions(hello_window
    PRIVATE
        UNICODE
        _UNICODE
)
