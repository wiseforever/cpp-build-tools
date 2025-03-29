#!/bin/bash

# 检查第一个参数
if [ "$1" == "Debug" ]; then
    BUILD_TYPE="Debug"
    # ./build/Debug/bin/application
elif [ "$1" == "Release" ]; then
    BUILD_TYPE="Release"
    # ./build/Release/bin/application
else
    echo "无效的选项，请使用 Debug 或 Release"
    exit 1
fi

# !!!注意::
# 切换到脚本所在目录赋值给 SCRIPT_DIR 变量
# 但实际shell中并没有进入脚本所在目录，所以此处的脚本目录是相对路径
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
    ./build/gcc-${BUILD_TYPE}/bin/${application_name}
elif [ "$user_compiler_type" == "msvc" ]; then
    echo ""
    ./build/msvc-${BUILD_TYPE}/bin/${application_name}
elif [ "$user_compiler_type" == "clang" ]; then
    echo ""
    ./build/clang-${BUILD_TYPE}/bin/${application_name}
else
    echo "Unknown user_compiler_type: $user_compiler_type"
    exit 1
fi
