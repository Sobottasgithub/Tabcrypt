cmake_minimum_required(VERSION 3.10)
project(tabcrypt-test)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

file(GLOB_RECURSE SOURCES "./*.cpp" "./*.h")

add_executable(tabcrypt-test ${SOURCES})

target_link_libraries(tabcrypt-test PRIVATE tabcrypt)
target_link_libraries(tabcrypt-test PRIVATE tablog)

install(TARGETS tabcrypt-test DESTINATION bin)
