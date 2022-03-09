cmake_minimum_required(VERSION 3.5)
project (AllegroProject)

# include(FetchContent)
# FetchContent_Declare(
#   allegro5
#   GIT_REPOSITORY https://github.com/liballeg/allegro5.git
#   GIT_TAG        5.2.7.0
# )
# FetchContent_GetProperties(allegro5)
# if(NOT allegro5_POPULATED)
#   FetchContent_Populate(allegro5)
# 	set(WANT_FONT ON)
# 	set(ALLEGRO_LIB_BUILD ON)
# 	set(WANT_FRAMEWORKS ON)
# 	set(CMAKE_INSTALL_PREFIX ${allegro5_BINARY_DIR}/installed)
#   add_subdirectory(${allegro5_SOURCE_DIR} ${allegro5_BINARY_DIR} EXCLUDE_FROM_ALL)
# 	# set(CMAKE_MODULE_PATH "${allegro5_BINARY_DIR}/lib;${CMAKE_MODULE_PATH}")
# 	# find_package(allegro REQUIRED)

# 	# include(FindPkgConfig)
# 	# set(ENV{PKG_CONFIG_PATH} "${allegro5_BINARY_DIR}/libs")
# 	# pkg_search_module(allegro5 REQUIRED allegro-5)
# endif()

# # target_include_directories(app SYSTEM PUBLIC ${SDL2_INCLUDE_DIRS})
# # target_link_libraries(app ${SDL2_LIBRARIES})

# add_executable(allegroProject main.c common.c)
# target_link_libraries(allegroProject LINK_PUBLIC allegro allegro_font)
# target_include_directories(allegroProject PUBLIC ${allegro5_SOURCE_DIR}/include)
# target_include_directories(allegroProject PUBLIC ${allegro5_BINARY_DIR}/include)

# message(STATUS "======: ${allegro5_INCLUDE_DIRS}")
# message(STATUS ${allegro5_LIBRARIES})

# # file(COPY ${allegro5_SOURCE_DIR}/addons/font/allegro5/allegro_font.h
# # 	DESTINATION ${allegro5_SOURCE_DIR}/include/allegro5
# # )
# # file(COPY ${allegro5_SOURCE_DIR}/addons/primitives/allegro5/allegro_primitives.h
# # 	DESTINATION ${allegro5_SOURCE_DIR}/include/allegro5
# # )

# target_link_libraries(allegroProject LINK_PUBLIC allegro_font allegro_primitives)

# ========

include(ExternalProject)
set(CMAKE_BUILD_TYPE "Debug")
ExternalProject_Add(allegro5
    GIT_REPOSITORY    https://github.com/liballeg/allegro5.git
    GIT_TAG           5.2.7.0
		PREFIX            "${CMAKE_CURRENT_BINARY_DIR}/allegro5-src"
		BUILD_IN_SOURCE
    BUILD_COMMAND     cmake --build "${CMAKE_CURRENT_BINARY_DIR}/allegro5-src/src/allegro5-build"
    INSTALL_COMMAND   cmake --build "${CMAKE_CURRENT_BINARY_DIR}/allegro5-src/src/allegro5-build" -t install
    TEST_COMMAND      ""
		INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}/allegro5-install
		CMAKE_ARGS
			-DCMAKE_INSTALL_PREFIX=${CMAKE_CURRENT_BINARY_DIR}/allegro5-install
			-DCMAKE_BUILD_TYPE="Debug"
			-DWANT_TESTS=OFF
			-DWANT_EXAMPLES=OFF
    )

# find_library(allegro_lib NAMES allegro REQUIRED HINTS ${CMAKE_CURRENT_BINARY_DIR}/allegro5-install)
# message(STATUS "======== ${allegro_lib}")

add_executable(al_example src/main.c)
add_dependencies(al_example allegro5)
target_include_directories(al_example PUBLIC ${CMAKE_CURRENT_BINARY_DIR}/allegro5-install/include)
target_link_directories(al_example PUBLIC ${CMAKE_CURRENT_BINARY_DIR}/allegro5-install/lib)
target_link_libraries(al_example LINK_PUBLIC allegro allegro_main allegro_font allegro_primitives)

# ========

