
set(jpeg_source "${CMAKE_CURRENT_BINARY_DIR}/build/jpeg")
set(jpeg_install "${CMAKE_CURRENT_BINARY_DIR}/Externals")

configure_file(${cdat_CMAKE_SOURCE_DIR}/jpeg_install_step.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/jpeg_install_step.cmake
    @ONLY)

set(jpeg_INSTALL_COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/jpeg_install_step.cmake)

ExternalProject_Add(jpeg
  DOWNLOAD_DIR ${CMAKE_CURRENT_BINARY_DIR}
  SOURCE_DIR ${jpeg_source}
  INSTALL_DIR ${jpeg_install}
  URL ${JPEG_URL}/${JPEG_GZ}
  URL_MD5 ${JPEG_MD5}
  BUILD_IN_SOURCE 1
  PATCH_COMMAND ""
  CONFIGURE_COMMAND ${CMAKE_COMMAND} -DINSTALL_DIR=<INSTALL_DIR> -DWORKING_DIR=<SOURCE_DIR> -P ${cdat_CMAKE_BINARY_DIR}/cdat_configure_step.cmake
  INSTALL_COMMAND ${jpeg_INSTALL_COMMAND}
)



set(jpeg_DIR "${jpeg_binary}" CACHE PATH "jpeg binary directory" FORCE)
mark_as_advanced(jpeg_DIR)
