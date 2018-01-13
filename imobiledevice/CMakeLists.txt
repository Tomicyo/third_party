cmake_minimum_required(VERSION 3.2)
set_property(GLOBAL PROPERTY USE_FOLDERS ON)
project(iMobile)

if (${CMAKE_CXX_COMPILER_ID} STREQUAL "MSVC")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP")
endif()

# Predefine OpenSSL dependency
set(OPENSSL_INC "${ThirdParty_SOURCE_DIR}/artifacts/win64/include")
set(OPENSSL_LIBDIR "${ThirdParty_SOURCE_DIR}/artifacts/win64/lib/win64_vc150r")

include_directories(.)
include_directories(include)
include_directories(plist/include)

add_subdirectory(plist)
add_subdirectory(src)
add_subdirectory(examples)

install(DIRECTORY include/libimobiledevice DESTINATION include)