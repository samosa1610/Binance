cmake_minimum_required(VERSION 3.16)

project(QtGuiApp VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)

# Find Qt libraries
find_package(Qt5 COMPONENTS Widgets Core REQUIRED)

# Add source files
set(SOURCES
    main.cpp
    mainwindow.cpp
)

set(HEADERS
    mainwindow.h
)

set(UI_FILES
    mainwindow.ui
)

# Process UI files
qt5_wrap_ui(UI_HEADERS ${UI_FILES})

# Create the executable
add_executable(QtGuiApp ${SOURCES} ${HEADERS} ${UI_HEADERS})

# Link Qt libraries
target_link_libraries(QtGuiApp PRIVATE Qt5::Widgets Qt5::Core)

# Ensure order.sh is executable
add_custom_command(TARGET QtGuiApp POST_BUILD
    COMMAND chmod +x ${CMAKE_SOURCE_DIR}/order.sh
    COMMENT "Making order.sh executable"
)

