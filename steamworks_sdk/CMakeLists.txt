install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/public/steam
  DESTINATION include
)

if(WIN32)
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/redistributable_bin/win64/steam_api64.lib
  DESTINATION lib
)
endif()