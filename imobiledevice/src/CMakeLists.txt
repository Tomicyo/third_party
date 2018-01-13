include_directories(.)
include_directories(common)
include_directories(libusbmuxd/include)

add_subdirectory(common)
add_subdirectory(libusbmuxd)
#add_subdirectory(libimobiledevice)

add_library(imobiledevice SHARED
afc.c
debugserver.c
device_link_service.c
diagnostics_relay.c
file_relay.c
heartbeat.c
house_arrest.c
idevice.c
installation_proxy.c
lockdown.c
misagent.c
mobile_image_mounter.c
mobileactivation.c
mobilebackup.c
mobilebackup2.c
mobilesync.c
notification_proxy.c
pinvoke.c
property_list_service.c
restore.c
sbservices.c
screenshotr.c
service.c
syslog_relay.c
webinspector.c
)
target_link_libraries(imobiledevice common_im libusbmuxd plist 
    ${OPENSSL_LIBDIR}/libssl.lib 
    ${OPENSSL_LIBDIR}/libcrypto.lib)
target_include_directories(imobiledevice PRIVATE ${OPENSSL_INC})
target_compile_definitions(imobiledevice PRIVATE HAVE_OPENSSL=1)
set_target_properties(imobiledevice PROPERTIES FOLDER "libimobiledevice")

install(TARGETS imobiledevice
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib )