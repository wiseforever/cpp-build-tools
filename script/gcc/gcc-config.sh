#!/bin/bash

# GCC 配置脚本

# 检查第一个参数
if [ "$1" == "Debug" ]; then
    BUILD_TYPE="Debug"
elif [ "$1" == "Release" ]; then
    BUILD_TYPE="Release"
else
    echo "无效的选项，请使用 Debug 或 Release"
    exit 1
fi

# 设置变量
BASE_DIR=.
BUILD_DIR="${BASE_DIR}/build/gcc-${BUILD_TYPE}"
PARALLEL_JOBS=16


echo "=== 开始 GCC 配置 ==="
echo "构建类型: ${BUILD_TYPE}"
echo "构建目录: ${BUILD_DIR}"
echo "并行任务数: ${PARALLEL_JOBS}"


cmake -S . -B "${BUILD_DIR}" -G "Ninja" -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" -DUSER_COMPILER=GCC

# # 检查最后一条命令的退出状态
# if [ $? -eq 0 ]; then
#     echo "构建过程完成"
#     exit 0
# else
#     echo "构建过程失败"
#     exit 1
# fi