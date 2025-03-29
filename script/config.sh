#!/bin/bash

# 检查第一个参数
if [ "$1" == "Debug" ]; then
    BUILD_TYPE="Debug"
elif [ "$1" == "Release" ]; then
    BUILD_TYPE="Release"
else
    echo "无效的选项，请使用 Debug 或 Release"
    exit 1
fi

# 兼容性更好的方式
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

FILE="${SCRIPT_DIR}/user_compiler.sh"

if [ ! -f "$FILE" ]; then
    # echo "Error: Required file '$FILE' is missing." >&2  # 错误信息输出到 stderr
    # echo "Please ensure the file is in the current directory." >&2
    echo "Error: Required file '$FILE' is missing."
    echo "Please ensure the file is in the current directory."
    exit 1
fi

source ${FILE}  # 导入 user_compiler.sh 中的变量

if [ "$user_compiler_type" == "gcc" ]; then
    echo ""
    # echo "user_compiler_type is gcc"
elif [ "$user_compiler_type" == "msvc" ]; then
    echo ""
    # echo "user_compiler_type is msvc"
elif [ "$user_compiler_type" == "clang" ]; then
    echo ""
    # echo "user_compiler_type is clang"
else
    echo "Unknown user_compiler_type: $user_compiler_type"
    exit 1
fi

# 检查 CMakeLists.txt 是否存在
if [ -f "CMakeLists.txt" ]; then
    echo "找到 CMakeLists.txt"
    # 在此添加CMake命令（例如：cmake .）
else
    echo "错误：当前目录未找到 CMakeLists.txt"
    exit 1
fi

# !!!注意::
# 切换到脚本所在目录赋值给 SCRIPT_DIR 变量
# 但实际shell中并没有进入脚本所在目录，所以此处的脚本目录是相对路径
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

${SCRIPT_DIR}/${user_compiler_type}/${user_compiler_type}-config.sh ${BUILD_TYPE}

