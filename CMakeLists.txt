cmake_minimum_required(VERSION 2.6)

find_package(Boost REQUIRED COMPONENTS unit_test_framework)
find_package(Qt4 REQUIRED COMPONENTS)

enable_testing()
set(CMAKE_VERBOSE_MAKEFILE TRUE)

add_subdirectory(tests)
