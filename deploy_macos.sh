pushd .
git config --global user.email "dsotsen@npurobot.com"
git config --global user.name "Dso Tsin"

function upload_mac()
{
	mk_config=$1
	cd /Users/travis/build/Tomicyo/kaleido3d/Source/ThirdParty_Prebuilt/MacOS/$mk_config
	git init
	git add .
	git commit -m "update build macos (confg=$mk_config)"
	git remote add origin https://$PREFIX@github.com/Tomicyo/kaleido3d_dep_prebuilt.git
	git branch macos_$mk_config
	git push -u -f origin macos_$mk_config
}

upload_mac Debug;
upload_mac Release;