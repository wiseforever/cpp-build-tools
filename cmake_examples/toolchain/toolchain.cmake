### Include toolchain file
# include("cmake/gcc-arm-none-eabi.cmake")
# include("cmake/toolchain/mingw64.cmake")
# include("cmake/toolchain/msvc.cmake")

if(DEFINED USER_COMPILER)
    message(STATUS "USER_COMPILER is defined as: ${USER_COMPILER}")
else()
    message(WARNING "USER_COMPILER is not defined!")
endif()

# 根据变量值执行逻辑
if(USER_COMPILER STREQUAL "GCC")
    # message(STATUS "Using GCC compiler")
    include("${CMAKE_SOURCE_DIR}/cmake/toolchain/mingw64.cmake")
elseif(USER_COMPILER STREQUAL "MSVC")
    # message(STATUS "Using MSVC compiler")
    include("${CMAKE_SOURCE_DIR}/cmake/toolchain/msvc.cmake")
elseif(USER_COMPILER STREQUAL "CLANG")
    # message(STATUS "Using CLANG compiler")
else()
    message(FATAL_ERROR "Unknown compiler: ${USER_COMPILER}")
endif()
