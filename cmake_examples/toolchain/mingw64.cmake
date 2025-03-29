# set(CMAKE_C_COMPILER_FORCED TRUE) # 跳过 CMake 的编译器检测（避免自动检测失败或耗时）
# set(CMAKE_CXX_COMPILER_FORCED TRUE)
# set(CMAKE_C_COMPILER_ID GNU) # 显式声明编译器为 GNU GCC
# set(CMAKE_CXX_COMPILER_ID GNU)

# Some default GCC settings
# arm-none-eabi- must be part of path environment
file(TO_CMAKE_PATH "$ENV{QTMINGW653}" TOOLCHAIN_PATH)
if (TOOLCHAIN_PATH)
    # message(STATUS "TOOLCHAIN_PATH: " ${TOOLCHAIN_PATH})
    set(TOOLCHAIN_PREFIX ${TOOLCHAIN_PATH}/bin/)
endif()

if(CMAKE_HOST_WIN32)
    message(STATUS "Using Windows!!!")
    # set(CMAKE_C_COMPILER clang.exe)
    # set(CMAKE_CXX_COMPILER clang++.exe)
    set(CMAKE_C_COMPILER        "${TOOLCHAIN_PREFIX}gcc.exe")
    set(CMAKE_CXX_COMPILER      "${TOOLCHAIN_PREFIX}g++.exe")
    # set(CMAKE_ASM_COMPILER      "${CMAKE_C_COMPILER}")
    # set(CMAKE_LINKER            "${CMAKE_CXX_COMPILER}")
    # set(CMAKE_OBJCOPY           "${TOOLCHAIN_PREFIX}objcopy.exe")
    # set(CMAKE_SIZE              "${TOOLCHAIN_PREFIX}size.exe")
else()
    message(STATUS "Using Linux!!!")
    # set(CMAKE_C_COMPILER clang)
    # set(CMAKE_CXX_COMPILER clang++)
    set(CMAKE_C_COMPILER        "${TOOLCHAIN_PREFIX}gcc")
    set(CMAKE_CXX_COMPILER      "${TOOLCHAIN_PREFIX}g++")
    # set(CMAKE_ASM_COMPILER      "${CMAKE_C_COMPILER}")
    # set(CMAKE_LINKER            "${CMAKE_CXX_COMPILER}")
    # set(CMAKE_OBJCOPY           "${TOOLCHAIN_PREFIX}objcopy")
    # set(CMAKE_SIZE              "${TOOLCHAIN_PREFIX}size")
endif()

# set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY) # EXECUTABLE or STATIC_LIBRARY

# Define the build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug")
endif()
message(STATUS "Build type: " ${CMAKE_BUILD_TYPE})

if(CMAKE_BUILD_TYPE MATCHES Debug)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O2 -g3")
endif()
if(CMAKE_BUILD_TYPE MATCHES Release)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Os -g0")
endif()


# add custom compile and linker flags
set(CUSTOM_C_FLAGS
    -Wall           # 启用所有警告
    -Wextra         # 启用额外的警告
    -Wpedantic      # 启用兼容性警告 要求严格遵循标准
    -Wno-unused-variable    # 禁用未使用的变量警告
    -Wno-unused-parameter   # 禁用未使用的参数警告
    -Wno-unused-function    # 禁用未使用的函数警告
    -Wno-unused-but-set-variable   # 禁用未使用但被设置的变量警告
    # -Wno-format  # 禁用格式化字符串警告
    -Wno-comment   # 禁用多行注释警告
    -Wno-pedantic  # 禁用不严谨的警告 如: 空文件等
    # -fexec-charset=utf-8   # 编译源文件字符集为 utf-8 or gbk
    # -mwindows   # 编译为windows可执行程序
)

set(CUSTOM_CXX_FLAGS
    ${CUSTOM_C_FLAGS}
)

string(JOIN " " CUSTOM_C_FLAGS_STR ${CUSTOM_C_FLAGS})
string(JOIN " " CUSTOM_CXX_FLAGS_STR ${CUSTOM_CXX_FLAGS})


set(CUSTOM_C_LINK_FLAGS 
    # -Wl,--no-warn-rwx-segments
    # -lnosys
    # -Wl,--wrap,malloc # 不使用系统malloc函数
    # -Wl,--wrap,free  # 不使用系统free函数
    # -Wl,--wrap,calloc # 不使用系统calloc函数
    # -Wl,--wrap,realloc # 不使用系统realloc函数
    # -Wl,-Map=${PROJECT_NAME}.map
    -Wl,--gc-sections # 链接时优化代码 去除未引用的函数和数据 减少代码大小 加快链接速度
    -static-libgcc # 静态链接gcc库
)

set(CUSTOM_CXX_LINK_FLAGS
    ${CUSTOM_C_LINK_FLAGS}
    -static-libstdc++ # 静态链接stdc++库
    -Wl,--start-group
    -lm # 链接math库
    # -lstdc++
    # -lsupc++
    -Wl,--end-group
)

string(JOIN " " CUSTOM_C_LINK_FLAGS_STR ${CUSTOM_C_LINK_FLAGS})
string(JOIN " " CUSTOM_CXX_LINK_FLAGS_STR ${CUSTOM_CXX_LINK_FLAGS})


set(CMAKE_ASM_FLAGS "${CMAKE_C_FLAGS} -x assembler-with-cpp -MMD -MP")
# set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Werror=implicit-function-declaration")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CUSTOM_C_FLAGS_STR}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CUSTOM_CXX_FLAGS_STR}")
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} ${CUSTOM_C_LINK_FLAGS_STR}")
set(CMAKE_CXX_LINK_FLAGS "${CMAKE_CXX_LINK_FLAGS} ${CUSTOM_CXX_LINK_FLAGS_STR}")
