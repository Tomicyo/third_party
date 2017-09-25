CMAKE_BIN=$CMAKE_DIR/bin/cmake
CMAKE_NINJA=$CMAKE_DIR/bin/ninja
CMAKE_TOOLCHAIN=$ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake

MK_OPT="-DCMAKE_MAKE_PROGRAM=$CMAKE_NINJA -DANDROID_NDK=$ANDROID_NDK_HOME -DANDROID_TOOLCHAIN=clang -DCMAKE_TOOLCHAIN_FILE=$CMAKE_TOOLCHAIN"
INSTALL_DIR=../kaleido3d/Source/ThirdParty_Prebuilt

function build() # Debug armeabi-v7a 23 23 gnustl_static
{
	set -e
	mk_config=$1
	mk_abi=$2
	mk_lev=$3
	mk_plat=$4
	mk_stl=$5
	mk_intermediate=build/android/$mk_config/$mk_stl/$mk_abi
	mk_prefix=$INSTALL_DIR/Android/$mk_config/$mk_stl/$mk_abi
	mk_android_opt="-DANDROID_ABI=$mk_abi -DANDROID_NATIVE_API_LEVEL=$mk_lev -DANDROID_PLATFORM=android-$mk_plat -DANDROID_STL=$mk_stl -DANDROID_CPP_FEATURES=rtti;exceptions"
	$CMAKE_BIN -G"Android Gradle - Ninja" $MK_OPT $mk_android_opt -H. -B$mk_intermediate -DCMAKE_BUILD_TYPE=$mk_config -DCMAKE_INSTALL_PREFIX=$mk_prefix
	$CMAKE_BIN --build $mk_intermediate --config $mk_config --target install
}

# Debug build
#build Debug armeabi-v7a 23 23 gnustl_shared;
build Debug armeabi-v7a 23 23 c++_shared;
#build Debug arm64-v8a 23 23 gnustl_shared;
build Debug arm64-v8a 23 23 c++_shared;
# Relase build
#build Release armeabi-v7a 23 23 gnustl_shared;
build Release armeabi-v7a 23 23 c++_shared;
#build Release arm64-v8a 23 23 gnustl_shared;
build Release arm64-v8a 23 23 c++_shared;