
set(gui_support_source ${cdat_SOURCE_DIR}/Packages/gui_support)

get_filename_component(QT_BINARY_DIR ${QT_QMAKE_EXECUTABLE} PATH)
get_filename_component(QT_ROOT ${QT_BINARY_DIR} PATH)

#env EXTERNALS=/Users/partyd/Kitware/uv-cdat/make-file-install//Externals  LDFLAGS="${LDFLAGS/"/} -undefined dynamic_lookup"  /Users/partyd/Kitware/uv-cdat/make-file-install//bin/python install.py  --enable-qt-framework  --with-qt=/Users/partyd/Kitware/uv-cdat/make-file-install//Externals

if(APPLE)
  set(qt_flags "--enable-qt-framework --with-qt=${QT_ROOT}")
else()
  set(qt_flags "--with-qt=${QT_ROOT}")
endif()

if(CDAT_USE_SYSTEM_QT AND QT_QTCORE_INCLUDE_DIR)
  get_filename_component(QT_INCLUDE_ROOT ${QT_QTCORE_INCLUDE_DIR} PATH)
  set(ADDITIONAL_CPPFLAGS "-I${QT_INCLUDE_ROOT}")
endif()

configure_file(${cdat_CMAKE_SOURCE_DIR}/cdat_python_install_step.cmake.in
  ${cdat_CMAKE_BINARY_DIR}/cdat_python_install_step.cmake
  @ONLY)

ExternalProject_Add(gui_support
  DOWNLOAD_DIR ""
  SOURCE_DIR ${gui_support_source}
  BUILD_IN_SOURCE 1
  PATCH_COMMAND ""
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND env EXTERNALS=${cdat_BINARY_DIR}/Externals ${LIBRARY_PATH}=${RUNTIME_FLAGS} ${PYTHON_EXECUTABLE} setup.py build --force install
  #INSTALL_COMMAND ${CMAKE_COMMAND} -DWORKING_DIR=<SOURCE_DIR> -DPYTHON_INSTALL_ARGS=${qt_flags} -P ${cdat_CMAKE_BINARY_DIR}/cdat_python_install_step.cmake
  DEPENDS ${gui_support_DEPENDENCIES}
)

