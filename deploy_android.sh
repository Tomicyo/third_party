#!/bin/bash
git config --global user.email "dsotsen@gmail.com"
git config --global user.name "Tomicyo"

function upload_android()
{
	mk_config=$1
	mk_stl=$2
	mk_abi=$3
	cd /home/ubuntu/kaleido3d/Source/ThirdParty_Prebuilt/Android/$mk_config/$mk_stl/$mk_abi
	git init
	git add .
	git commit -m "update build android (config=$mk_config stl=$mk_stl abi=$mk_abi)"
	git remote add origin https://github.com/Tomicyo/kaleido3d_dep_prebuilt.git
	git branch android_$mk_abi\_$mk_stl\_$mk_config
	git push -u -f origin android_$mk_abi\_$mk_stl\_$mk_config
}

upload_android Debug c++_shared armeabi-v7a;
#upload_android Debug gnustl_shared armeabi-v7a;
upload_android Debug c++_shared arm64-v8a;
#upload_android Debug gnustl_shared arm64-v8a;

upload_android Release c++_shared armeabi-v7a;
#upload_android Release gnustl_shared armeabi-v7a;
upload_android Release c++_shared arm64-v8a;
#upload_android Release gnustl_shared arm64-v8a;