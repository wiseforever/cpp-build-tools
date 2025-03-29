# cpp-build-tools
## 介绍
cpp-build-tools是一个用于编译C++项目的工具，它依赖cmake、ninja工具，并提供一系列的脚本来简化编译流程。

## 依赖

- cmake（需要加入到PATH环境变量中）
- ninja（需要加入到PATH环境变量中）
- bash (linux/macos/git-bash ...)

## 使用方法

### 配置cpp-build-tools

1. 将cpp-build-tools放到任意目录（建议放在需要编译的项目目录下或者项目目录的上级目录）。

1. 或者将cpp-build-tools/scripts目录放到PATH环境变量中，这样就可以在任意目录下执行命令。

1. cmake_examples目录下提供了mingw64、msvc编译器的示例。将cmake_examples目录更名为cmake，并且修改对应编译器对应.cmake的CMAKE_C_COMPILER和CMAKE_CXX_COMPILER变量。

1. 将cmake目录放在顶层CMakeLists.txt中同级目录下，在顶层CMakeLists.txt中的project()之前添加 include(cmake/toolchain/toolchain.cmake) 即可。

### 使用cpp-build-tools

1. 若将cpp-build-tools放到项目目录下，则直接进入项目目录。

1. scripts目录下的user_compiler.sh脚本可以设置编译器类型和可执行程序的名称。

1. user_compiler_type 变量可以设置编译器类型，例如：gcc、msvc、clang等。

1. application_name变量可以设置可执行程序的名称，例如：application。对应的是CMakeLists.txt中的project()命令中的PROJECT_NAME。

```bash
# 进入项目目录
cd <project_dir>

# 配置cmake项目 Debug 或者 Release 版本
./cpp-build-tools/script/config.sh Debug
./cpp-build-tools/script/config.sh Release

# 编译 Debug 版本 或者 Release 版本
./cpp-build-tools/script/build.sh Debug
./cpp-build-tools/script/build.sh Release

# 运行程序
./cpp-build-tools/script/run.sh Debug
./cpp-build-tools/script/run.sh Release

# 清理项目
./cpp-build-tools/script/clean.sh Debug
./cpp-build-tools/script/clean.sh Release

```