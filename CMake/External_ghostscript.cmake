
set(ghostscript_source "${CMAKE_CURRENT_BINARY_DIR}/ghostscript")
set(ghostscript_binary "${CMAKE_CURRENT_BINARY_DIR}/ghostscript-build")
set(ghostscript_install "${CMAKE_CURRENT_BINARY_DIR}/ghostscript-install")

ExternalProject_Add(ghostscript
  DOWNLOAD_DIR ${CMAKE_CURRENT_BINARY_DIR}
  SOURCE_DIR ${ghostscript_source}
  BINARY_DIR ${ghostscript_build}
  INSTALL_DIR ${ghostscript_install}
  URL ${GS_URL}/${GS_GZ}
  URL_MD5 ${GS_MD5}
  BUILD_IN_SOURCE 1
  PATCH_COMMAND ""
  CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR>
)

set(ghostscript_DIR "${ghostscript_binary}" CACHE PATH "ghostscript binary directory" FORCE)
mark_as_advanced(ghostscript_DIR)
