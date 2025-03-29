# 定义函数封装库设置

# 不递归
function(ez_create_library LIB_NAME LIB_TYPE LIB_SCOPE)
    # 检查参数数量是否足够
    if(NOT LIB_NAME OR NOT LIB_TYPE OR NOT LIB_SCOPE)
        message(FATAL_ERROR "ez_create_library requires at least 3 arguments: LIB_NAME, LIB_TYPE, and LIB_SCOPE.")
    endif()

    # 检查 LIB_TYPE 是否为 STATIC, SHARED 或 INTERFACE
    if(NOT (LIB_TYPE STREQUAL "STATIC" OR LIB_TYPE STREQUAL "SHARED" OR LIB_TYPE STREQUAL "INTERFACE"))
        message(FATAL_ERROR "LIB_TYPE must be one of STATIC, SHARED, or INTERFACE.")
    endif()

    # 检查 LIB_SCOPE 是否为 PUBLIC, PRIVATE 或 INTERFACE
    if(NOT (LIB_SCOPE STREQUAL "PUBLIC" OR LIB_SCOPE STREQUAL "PRIVATE" OR LIB_SCOPE STREQUAL "INTERFACE"))
        message(FATAL_ERROR "LIB_SCOPE must be one of PUBLIC, PRIVATE, or INTERFACE.")
    endif()

    # 检查当 LIB_TYPE 为 INTERFACE 时，LIB_SCOPE 必须为 INTERFACE
    if(LIB_TYPE STREQUAL "INTERFACE" AND NOT LIB_SCOPE STREQUAL "INTERFACE")
        message(FATAL_ERROR "When LIB_TYPE is INTERFACE, LIB_SCOPE must also be INTERFACE.")
    endif()

    # 创建库
    add_library(${LIB_NAME} ${LIB_TYPE})

    # 启用 CMake 对 C、C++ 和汇编语言的支持
    enable_language(C CXX ASM)

    # 设置编译定义
    target_compile_definitions(${LIB_NAME} ${LIB_SCOPE})

    ### 设置编译目录
    if(ARGN STREQUAL "")
        set(COMPILE_DIR "") # 如果未指定，默认使用当前目录
    else()
        set(COMPILE_DIR ${ARGN}) # 使用传入的目录
    endif()

    ### 获取源文件和头文件目录
    set(SOURCES)
    set(HEADER_DIRS)

    # 遍历 COMPILE_DIR 中的每一个目录，获取源文件与头文件路径
    foreach(dir IN LISTS COMPILE_DIR)
        file(GLOB temp_sources 
            ${dir}/*.c 
            ${dir}/*.cc 
            ${dir}/*.cpp 
            ${dir}/*.s 
            ${dir}/*.S
        )
        list(APPEND SOURCES ${temp_sources})

        file(GLOB temp_header_files 
            ${dir}/*.h
            ${dir}/*.hpp
            ${dir}/*.hxx
        )
        foreach(header_file ${temp_header_files})
            get_filename_component(header_dir ${header_file} DIRECTORY)
            list(APPEND HEADER_DIRS ${header_dir})
        endforeach()
    endforeach()

    # 去除重复的源文件和头文件目录
    list(REMOVE_DUPLICATES SOURCES)
    list(REMOVE_DUPLICATES HEADER_DIRS)

    # 输出调试信息
    # message(STATUS "lib${LIB_NAME}:\nSOURCES:\n${SOURCES}\nHEADER_DIRS:\n${HEADER_DIRS}\n")

    # 添加源文件和头文件目录到目标库
    target_sources(${LIB_NAME} ${LIB_SCOPE}
        ${SOURCES}
    )

    target_include_directories(${LIB_NAME} ${LIB_SCOPE}
        ${HEADER_DIRS}
    )
endfunction()

# 递归
function(ez_create_library_recurse LIB_NAME LIB_TYPE LIB_SCOPE)
    # 检查参数数量是否足够
    if(NOT LIB_NAME OR NOT LIB_TYPE OR NOT LIB_SCOPE)
        message(FATAL_ERROR "ez_create_library requires at least 3 arguments: LIB_NAME, LIB_TYPE, and LIB_SCOPE.")
    endif()

    # 检查 LIB_TYPE 是否为 STATIC, SHARED 或 INTERFACE
    if(NOT (LIB_TYPE STREQUAL "STATIC" OR LIB_TYPE STREQUAL "SHARED" OR LIB_TYPE STREQUAL "INTERFACE"))
        message(FATAL_ERROR "LIB_TYPE must be one of STATIC, SHARED, or INTERFACE.")
    endif()

    # 检查 LIB_SCOPE 是否为 PUBLIC, PRIVATE 或 INTERFACE
    if(NOT (LIB_SCOPE STREQUAL "PUBLIC" OR LIB_SCOPE STREQUAL "PRIVATE" OR LIB_SCOPE STREQUAL "INTERFACE"))
        message(FATAL_ERROR "LIB_SCOPE must be one of PUBLIC, PRIVATE, or INTERFACE.")
    endif()

    # 检查当 LIB_TYPE 为 INTERFACE 时，LIB_SCOPE 必须为 INTERFACE
    if(LIB_TYPE STREQUAL "INTERFACE" AND NOT LIB_SCOPE STREQUAL "INTERFACE")
        message(FATAL_ERROR "When LIB_TYPE is INTERFACE, LIB_SCOPE must also be INTERFACE.")
    endif()

    # 创建库
    add_library(${LIB_NAME} ${LIB_TYPE})

    # 启用 CMake 对 C、C++ 和汇编语言的支持
    enable_language(C CXX ASM)

    # 设置编译定义
    target_compile_definitions(${LIB_NAME} ${LIB_SCOPE})

    ### 设置编译目录
    if(ARGN STREQUAL "")
        set(COMPILE_DIR "") # 如果未指定，默认使用当前目录
    else()
        set(COMPILE_DIR ${ARGN}) # 使用传入的目录
    endif()

    ### 获取源文件和头文件目录
    set(SOURCES)
    set(HEADER_DIRS)

    # 遍历 COMPILE_DIR 中的每一个目录，获取源文件与头文件路径
    foreach(dir IN LISTS COMPILE_DIR)
        file(GLOB_RECURSE temp_sources 
            ${dir}/*.c 
            ${dir}/*.cc 
            ${dir}/*.cpp 
            ${dir}/*.s 
            ${dir}/*.S
        )
        list(APPEND SOURCES ${temp_sources})

        file(GLOB_RECURSE temp_header_files 
            ${dir}/*.h
            ${dir}/*.hpp
            ${dir}/*.hxx
        )
        foreach(header_file ${temp_header_files})
            get_filename_component(header_dir ${header_file} DIRECTORY)
            list(APPEND HEADER_DIRS ${header_dir})
        endforeach()
    endforeach()

    # 去除重复的源文件和头文件目录
    list(REMOVE_DUPLICATES SOURCES)
    list(REMOVE_DUPLICATES HEADER_DIRS)

    # 输出调试信息
    # message(STATUS "lib${LIB_NAME}:\nSOURCES:\n${SOURCES}\nHEADER_DIRS:\n${HEADER_DIRS}\n")

    # 添加源文件和头文件目录到目标库
    target_sources(${LIB_NAME} ${LIB_SCOPE}
        ${SOURCES}
    )

    target_include_directories(${LIB_NAME} ${LIB_SCOPE}
        ${HEADER_DIRS}
    )
endfunction()
