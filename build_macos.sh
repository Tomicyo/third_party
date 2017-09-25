INSTALL_ROOT=build/intermediate
function build()
{
	set -e
	mk_config=$1
	mk_prefix=$INSTALL_ROOT/$mk_config
	mk_intermediate=build/macos/$mk_config
	cmake -G"Xcode" -H. -B$mk_intermediate -DCMAKE_BUILD_TYPE=$mk_config -DCMAKE_INSTALL_PREFIX=$mk_prefix
	cmake --build $mk_intermediate --config $mk_config --target install
}

build Debug;
build Release;
if [ ! -d artifacts/lib/cmake ]; then
	mkdir -p artifacts/lib/cmake
fi;
cp -r $INSTALL_ROOT/Debug/include artifacts
cp -r $INSTALL_ROOT/Debug/lib/ artifacts/lib/osx64d
cp -r $INSTALL_ROOT/Release/lib/ artifacts/lib/osx64r
cp tools/third_party.cmake artifacts/lib/cmake
cd artifacts
zip -r third_party_darwin.zip ./*