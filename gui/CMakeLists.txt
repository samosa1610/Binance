cmake_minimum_required(VERSION 3.16)

project(QtGuiApp VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


add_executable(place ./place_orders/place.cpp)
add_executable(cancel ./place_orders/cancel.cpp)
