set(Traitlets_source "${CMAKE_CURRENT_BINARY_DIR}/build/Traitlets")

ExternalProject_Add(Traitlets
  DOWNLOAD_DIR ${CDAT_PACKAGE_CACHE_DIR}
  SOURCE_DIR ${Traitlets_source}
  URL ${TRAITLETS_URL}/${TRAITLETS_GZ}
  URL_MD5 ${TRAITLETS_MD5}
  BUILD_IN_SOURCE 1
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ${PYTHON_EXECUTABLE} setup.py build
  INSTALL_COMMAND ${PYTHON_EXECUTABLE} setup.py install ${PYTHON_EXTRA_PREFIX}
  DEPENDS ${Traitlets_deps}
  ${ep_log_options}
)
