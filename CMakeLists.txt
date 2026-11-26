cmake_minimum_required(VERSION 3.10)
project(tabcrypt)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(DEF_TABCRYPT "configure tabcrypt library" ON)
option(DEF_TEST "configure test" ON)

if(DEF_TABCRYPT)
    add_subdirectory(lib/tabcrypt)
endif()

if(DEF_TEST)
    add_subdirectory(test)
endif()
