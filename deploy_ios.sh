pushd .
git config --global user.email "dsotsen@npurobot.com"
git config --global user.name "Dso Tsin"

function upload_iOS()
{
	build_dir=/Users/travis/build/Tomicyo/kaleido3d/Source/ThirdParty_Prebuilt/iOS/$1
	if [ -d $build_dir ]; then
		cd $build_dir
		git init
		git add .
		git commit -m "update build iOS $1"
		git remote add origin https://$PREFIX@github.com/Tomicyo/kaleido3d_dep_prebuilt.git
		git branch ios_$1
		git push -u -f origin ios_$1
	fi;
}

upload_iOS Debug;
upload_iOS Release;

popd