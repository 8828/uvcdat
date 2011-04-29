
set(jasper_source "${CMAKE_CURRENT_BINARY_DIR}/build/png")
set(jasper_install "${CMAKE_CURRENT_BINARY_DIR}/Externals")

ExternalProject_Add(png
  DOWNLOAD_DIR ${CMAKE_CURRENT_BINARY_DIR}
  SOURCE_DIR ${jasper_source}
  INSTALL_DIR ${jasper_install}
  URL ${JASPER_URL}/${JASPER_GZ}
  URL_MD5 ${JASPER_MD5}
  BUILD_IN_SOURCE 1
  PATCH_COMMAND ""
  CONFIGURE_COMMAND ${CMAKE_COMMAND} -DINSTALL_DIR=<INSTALL_DIR> -DWORKING_DIR=<SOURCE_DIR> -P ${cdat_CMAKE_BINARY_DIR}/cdat_configure_step.cmake
  DEPENDS ${jasper_DEPENDENCIES}
)
