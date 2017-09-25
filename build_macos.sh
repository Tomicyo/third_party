INSTALL_ROOT=../kaleido3d/Source/ThirdParty_Prebuilt

function build()
{
	set -e
	mk_config=$1
	mk_prefix=$INSTALL_ROOT/MacOS/$mk_config
	mk_intermediate=build/macos/$mk_config
	cmake -G"Xcode" -H. -B$mk_intermediate -DCMAKE_BUILD_TYPE=$mk_config -DCMAKE_INSTALL_PREFIX=$mk_prefix
	cmake --build $mk_intermediate --config $mk_config --target install
}

build Debug;
build Release;