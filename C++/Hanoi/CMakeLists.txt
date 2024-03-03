cmake_minimum_required(VERSION 3.26)
project(Hanoi)

set(CMAKE_CXX_STANDARD 20)

add_executable(Hanoi main.cpp
        stack.h
        hanoi.h
        timer.h)
