# cpp-build-tools
## 介绍
cpp-build-tools是一个用于编译C++项目的工具，它依赖cmake、ninja工具，并提供一系列的脚本来简化编译流程。

## 依赖

- cmake（需要加入到PATH环境变量中）
- ninja（需要加入到PATH环境变量中）
- bash(linux/macos/git-bash ...)

## 使用方法

1. 下载项目到本地

- 可以选择将cpp-build-tools放到任意目录（建议放在需要编译的项目目录下或者项目目录的上级目录）。
- 或者将cpp-build-tools/scripts目录放到PATH环境变量中，这样就可以在任意目录下执行命令。

2. 使用cpp-build-tools

- 若将cpp-build-tools放到项目目录下，则直接进入项目目录。
- scripts目录下的user_compiler.sh脚本可以设置编译器类型和可执行程序的名称。user_compiler_type变量可以设置编译器类型，例如：gcc、msvc、clang等。application_name变量可以设置可执行程序的名称，例如：application。

```bash
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

# 

```