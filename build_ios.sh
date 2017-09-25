INSTALL_ROOT=../kaleido3d/Source/ThirdParty_Prebuilt

function build()
{
	set -e
    cmake -DCMAKE_TOOLCHAIN_FILE=./ios.cmake -DIOS_PLATFORM=OS -H. -B.build.ios.$1 -GXcode -DCMAKE_BUILD_TYPE=$1 -DCMAKE_INSTALL_PREFIX=$INSTALL_ROOT/iOS/$1
    cmake --build .build.ios.$1/ --config $1 --target install
}

build Debug;
build Release;