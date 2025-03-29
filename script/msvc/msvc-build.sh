#!/bin/bash

# MSVC 构建脚本

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
VisualStudio_VCVARS="D:/Develop/VisualStudio/2019/Community/VC/Auxiliary/Build/vcvarsall.bat"
BASE_DIR=.
BUILD_DIR="${BASE_DIR}/build/msvc-${BUILD_TYPE}"
PARALLEL_JOBS=16

# 检查是否在 Windows 系统运行
if [[ "$OSTYPE" != "msys" && "$OSTYPE" != "cygwin" ]]; then
    echo "错误：此脚本需要在 Windows 系统上运行"
    exit 1
fi

# 检查 vcvarsall.bat 是否存在
if [ ! -f "${VisualStudio_VCVARS}" ]; then
    echo "错误：找不到 vcvarsall.bat 文件: ${VisualStudio_VCVARS}"
    exit 1
fi

echo "=== 开始 MSVC 构建 ==="
echo "构建类型: ${BUILD_TYPE}"
echo "构建目录: ${BUILD_DIR}"
echo "并行任务数: ${PARALLEL_JOBS}"

# 通过 cmd 调用 MSVC 环境设置和构建命令
cmd << EOD
call "${VisualStudio_VCVARS}" x64 && \
cmake -S ${BASE_DIR} -B "${BUILD_DIR}" -G "Ninja" -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" -DUSER_COMPILER=MSVC && \
cmake --build "${BUILD_DIR}" --target all --config=${BUILD_TYPE} -j${PARALLEL_JOBS}
EOD

# # 检查最后一条命令的退出状态
# if [ $? -eq 0 ]; then
#     echo "构建过程完成"
#     exit 0
# else
#     echo "构建过程失败"
#     exit 1
# fi