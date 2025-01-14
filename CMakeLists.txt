cmake_minimum_required(VERSION 3.10)
project(CurlJsonWebsocketsExample)

set(CMAKE_CXX_STANDARD 17)

# Find CURL and PkgConfig
find_package(CURL REQUIRED)
find_package(PkgConfig REQUIRED)

# Find jsoncpp using pkg-config
pkg_check_modules(JSONCPP jsoncpp)

# Find libwebsockets using pkg-config
pkg_check_modules(LWS libwebsockets)

# Define the executable with the new file name
add_executable(Test 1.cpp)

# Link include directories and libraries after defining the target
target_include_directories(Test PRIVATE 
    ${JSONCPP_INCLUDE_DIRS} 
    ${LWS_INCLUDE_DIRS}  # Include the websockets headers
)

target_link_libraries(Test PRIVATE 
    CURL::libcurl 
    ${JSONCPP_LIBRARIES} 
    ${LWS_LIBRARIES}  # Link libwebsockets
)
