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

BASE_DIR=$(pwd)

echo "rm -rf ${BASE_DIR}/build/msvc-${BUILD_TYPE}"
rm -rf ${BASE_DIR}/build/msvc-${BUILD_TYPE}
