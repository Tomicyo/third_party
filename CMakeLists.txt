cmake_minimum_required(VERSION 3.2)

project(ThirdParty)

if (MSVC)
    add_definitions(/MP)
endif()

if(${CMAKE_SYSTEM_NAME} STREQUAL "WindowsStore")
    add_definitions(/ZW)
endif()

set(gtest_force_shared_crt ON)

add_subdirectory(SPIRV-Cross)
add_subdirectory(SPIRV-Headers)
add_subdirectory(SPIRV-Tools)
add_subdirectory(rapidjson)
add_subdirectory(googletest)
add_subdirectory(glslang)

if(NOT APPLE)
	add_subdirectory(vulkan)
endif()

if(WIN32)
	add_subdirectory(dxsdk)
	add_subdirectory(steamworks_sdk)
endif()
