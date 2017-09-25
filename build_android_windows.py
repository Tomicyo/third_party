from tools.android import build_android_instance
from tools.windows import build_win64_instance
#from tools.download import download_and_extract
build_android_instance('arm64-v8a', 'gnustl_shared')
build_win64_instance(True, True)