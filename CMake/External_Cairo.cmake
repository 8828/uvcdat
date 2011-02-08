
set(Cairo_source "${CMAKE_CURRENT_BINARY_DIR}/build/Cairo")
set(Cairo_install "${CMAKE_CURRENT_BINARY_DIR}/Externals")

ExternalProject_Add(Cairo
  DOWNLOAD_DIR ${CMAKE_CURRENT_BINARY_DIR}
  SOURCE_DIR ${Cairo_source}
  INSTALL_DIR ${Cairo_install}
  URL ${CAIRO_URL}/${CAIRO_GZ}
  URL_MD5 ${CAIRO_MD5}
  BUILD_IN_SOURCE 1
  PATCH_COMMAND ""
  CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR>
  DEPENDS ${Cairo_DEPENDENCIES}
)

set(Cairo_DIR "${Cairo_binary}" CACHE PATH "Cairo binary directory" FORCE)
mark_as_advanced(Cairo_DIR)
