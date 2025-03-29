#!/bin/bash

# gcc msvc clang
user_compiler_type="gcc"

# application name is the name of the executable file.
# user can change it to any name they want.
# but it should be the same as the name of the project in the CMakeLists.txt file.
application_name="application"

export user_compiler_type
export application_name
