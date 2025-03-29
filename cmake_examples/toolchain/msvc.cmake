set(CMAKE_C_COMPILER        "D:/Develop/VisualStudio/2019/Community/VC/Tools/MSVC/14.29.30133/bin/Hostx64/x64/cl.exe")
set(CMAKE_CXX_COMPILER      "D:/Develop/VisualStudio/2019/Community/VC/Tools/MSVC/14.29.30133/bin/Hostx64/x64/cl.exe")


### Ninja -> msvc

# D:/Develop/VisualStudio/2019/Community/VC/Auxiliary/Build/vcvarsall.bat x64
# & "D:\Develop\VisualStudio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" x64
# call "D:\Develop\VisualStudio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" x64

# cmake -S . -B build/msvc-Debug -G "Ninja"
# cmake --build build/msvc-Debug --target all -j16

# cmake -S . -B build/msvc-Release -G "Ninja"
# cmake --build build/msvc-Release --target all -j16


### Visual Studio 2019
# cmake -S . -B build/msvc-Debug -G "Visual Studio 16 2019" -A x64
# cmake --build build/msvc-Debug -j16

# cmake -S . -B build/msvc-Release -G "Visual Studio 16 2019" -A x64
# cmake --build build/msvc-Release -j16