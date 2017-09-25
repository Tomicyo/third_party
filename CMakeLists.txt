cmake_minimum_required(VERSION 3.2)

project(ThirdParty)

if (${CMAKE_CXX_COMPILER_ID} STREQUAL "MSVC")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP")
endif()

if(${CMAKE_SYSTEM_NAME} STREQUAL "WindowsStore")
    add_definitions(/ZW)
endif()

set(gtest_force_shared_crt ON)

add_subdirectory(FreeType-2.7)
add_subdirectory(SPIRV-Cross)
add_subdirectory(SPIRV-Headers)
add_subdirectory(SPIRV-Tools)
add_subdirectory(glslang)
add_subdirectory(rapidjson)
add_subdirectory(googletest)

if(NOT ANDROID)
	add_subdirectory(zlib)
endif()

add_subdirectory(sqlite3)

if(NOT APPLE)
	add_subdirectory(vulkan)
endif()

if(WIN32)
	add_subdirectory(dxsdk)
	add_subdirectory(steamworks_sdk)
endif()
