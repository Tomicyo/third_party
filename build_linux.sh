INSTALL_ROOT=../kaleido3d/Source/ThirdParty_Prebuilt

function build()
{
	set -e
	mk_config=$1
	mk_prefix=$INSTALL_ROOT/Linux/$mk_config
	mk_intermediate=build/linux/$mk_config
	cmake -G"Unix Makefiles" -H. -B$mk_intermediate -DCMAKE_BUILD_TYPE=$mk_config -DCMAKE_INSTALL_PREFIX=$mk_prefix
	cmake --build $mk_intermediate --config $mk_config --target install
}

build Debug;
build Release;

cp tools/win_pack.py $INSTALL_ROOT/Linux
mkdir -p $INSTALL_ROOT/Linux/lib/cmake
cp tools/third_party.cmake $INSTALL_ROOT/Linux/lib/cmake
pushd .
cd $INSTALL_ROOT/Linux
python win_pack.py
popd