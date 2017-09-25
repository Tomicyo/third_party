get_filename_component(_install_prefix "${CMAKE_CURRENT_LIST_DIR}/../../" ABSOLUTE)

if(WIN32)
set(THIRD_PARTY_LIBDIR_DEBUG ${_install_prefix}/lib/win64_vc150d)
set(THIRD_PARTY_LIBDIR_RELEASE ${_install_prefix}/lib/win64_vc150r)
elseif(UNIX)
set(THIRD_PARTY_LIBDIR_DEBUG ${_install_prefix}/lib/linux64d)
set(THIRD_PARTY_LIBDIR_RELEASE ${_install_prefix}/lib/linux64r)
endif()

include_directories(${_install_prefix}/include)

macro(_imported_target_properties LIBNS TNAME Configuration IMPLIB_LOCATION)
    set_property(TARGET ${LIBNS}::${TNAME} APPEND PROPERTY IMPORTED_CONFIGURATIONS ${Configuration})
    if(NOT "${IMPLIB_LOCATION}" STREQUAL "")
            set_target_properties(${LIBNS}::${TNAME} PROPERTIES
            "IMPORTED_IMPLIB_${Configuration}" "${THIRD_PARTY_LIBDIR_${Configuration}}/${IMPLIB_LOCATION}"
            )
    endif()
endmacro()

macro(_imported_target_with_debug_fix LIBNS TNAME)
    add_library(${LIBNS}::${TNAME} SHARED IMPORTED)
    if(WIN32)
        _imported_target_properties(${LIBNS} ${TNAME} RELEASE "${TNAME}.lib" )
        _imported_target_properties(${LIBNS} ${TNAME} DEBUG "${TNAME}d.lib")
    elseif(UNIX)
        _imported_target_properties(${LIBNS} ${TNAME} RELEASE "lib${TNAME}.a" )
        _imported_target_properties(${LIBNS} ${TNAME} DEBUG "lib${TNAME}d.a")
    endif()
endmacro()

_imported_target_with_debug_fix(KHR glslang)
_imported_target_with_debug_fix(KHR HLSL)
_imported_target_with_debug_fix(KHR OGLCompiler)
_imported_target_with_debug_fix(KHR OSDependent)
_imported_target_with_debug_fix(KHR SPIRV)
_imported_target_with_debug_fix(KHR SPVRemapper)

set(GLSLANG_LIBRARIES KHR::glslang KHR::HLSL KHR::OGLCompiler KHR::OSDependent KHR::SPIRV KHR::SPVRemapper)

_imported_target_with_debug_fix(GTEST gtest)
_imported_target_with_debug_fix(GTEST gtest_main)
_imported_target_with_debug_fix(GTEST gmock)
_imported_target_with_debug_fix(GTEST gmock_main)

set(GTEST_LIBRARIES GTEST::gtest GTEST::gtest_main)

macro(_imported_target LIBNS TNAME)
    add_library(${LIBNS}::${TNAME} SHARED IMPORTED)
    if(WIN32)
        _imported_target_properties(${LIBNS} ${TNAME} RELEASE "${TNAME}.lib" )
        _imported_target_properties(${LIBNS} ${TNAME} DEBUG "${TNAME}.lib")
    elseif(UNIX)
        _imported_target_properties(${LIBNS} ${TNAME} RELEASE "lib${TNAME}.a" )
        _imported_target_properties(${LIBNS} ${TNAME} DEBUG "lib${TNAME}.a")
    endif()
endmacro()

_imported_target(KHR spirv-cross-core)
_imported_target(KHR spirv-cross-cpp)
_imported_target(KHR spirv-cross-glsl)
_imported_target(KHR spirv-cross-hlsl)
_imported_target(KHR spirv-cross-msl)

set(SPIRVCROSS_LIBRARIES 
KHR::spirv-cross-core
KHR::spirv-cross-cpp
KHR::spirv-cross-glsl
KHR::spirv-cross-hlsl
KHR::spirv-cross-msl
)

_imported_target(KHR SPIRV-Tools)
_imported_target(KHR SPIRV-Tools-comp)
_imported_target(KHR SPIRV-Tools-opt)

set(SPIRVTOOLS_LIBRARIES 
KHR::SPIRV-Tools
KHR::SPIRV-Tools-comp
KHR::SPIRV-Tools-opt
)

if(WIN32)
    macro(_imported_target_only_release LIBNS TNAME)
    add_library(${LIBNS}::${TNAME} SHARED IMPORTED)
    set_property(TARGET ${LIBNS}::${TNAME} APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
    set_property(TARGET ${LIBNS}::${TNAME} APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
    if(WIN32)
        set_target_properties(${LIBNS}::${TNAME} PROPERTIES
        "IMPORTED_IMPLIB_DEBUG" "${THIRD_PARTY_LIBDIR_RELEASE}/${TNAME}.lib"
        )
        set_target_properties(${LIBNS}::${TNAME} PROPERTIES
        "IMPORTED_IMPLIB_RELEASE" "${THIRD_PARTY_LIBDIR_RELEASE}/${TNAME}.lib"
        )
    endif()
    endmacro()

    _imported_target_only_release(V8 v8.dll)
    _imported_target_only_release(V8 v8_libbase.dll)
    _imported_target_only_release(V8 v8_libplatform.dll)
    _imported_target_only_release(V8 icuuc.dll)
    _imported_target_only_release(V8 icui18n.dll)

    set(V8_LIBRARIES 
    V8::v8.dll V8::v8_libbase.dll V8::v8_libplatform.dll
    V8::icuuc.dll V8::icui18n.dll
    )

    _imported_target(VK vulkan-1)
    set(VULKAN_LIBRARIES VK::vulkan-1)
endif()

_imported_target(FREETYPE freetype)
set(FREETYPE_LIBRARIES FREETYPE::freetype)
