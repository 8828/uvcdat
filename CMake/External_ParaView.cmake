
set(ParaView_source "${CMAKE_CURRENT_BINARY_DIR}/ParaView")
set(ParaView_binary "${CMAKE_CURRENT_BINARY_DIR}/ParaView-build")
set(ParaView_install "${cdat_EXTERNALS}")

set(ParaView_install_command "")
if(APPLE)
  set(ParaView_install_command "make install")
endif()

ExternalProject_Add(ParaView
  DOWNLOAD_DIR ${CMAKE_CURRENT_BINARY_DIR}
  SOURCE_DIR ${ParaView_source}
  BINARY_DIR ${ParaView_binary}
  INSTALL_DIR ${ParaView_install}
  URL ${PARAVIEW_URL}/${PARAVIEW_GZ}
  URL_MD5 ${PARAVIEW_MD5}
  PATCH_COMMAND ""
  CMAKE_CACHE_ARGS
    -DBUILD_SHARED_LIBS:BOOL=ON
    -DBUILD_TESTING:BOOL=OFF
    -DPARAVIEW_DISABLE_VTK_TESTING:BOOL=ON
    -DPARAVIEW_TESTING_WITH_PYTHON:BOOL=OFF
    -DCMAKE_CXX_FLAGS:STRING=${cdat_tpl_cxx_flags}
    -DCMAKE_C_FLAGS:STRING=${cdat_tpl_c_flags}
    -DCMAKE_BUILD_TYPE:STRING=${CMAKE_CFG_INTDIR}
    # Qt
    -DQT_QMAKE_EXECUTABLE:FILEPATH=${QT_QMAKE_EXECUTABLE}
    # Python
    -DPARAVIEW_ENABLE_PYTHON:BOOL=ON
    -DPYTHON_EXECUTABLE:FILEPATH=${PYTHON_EXECUTABLE}
    -DPYTHON_INCLUDE_DIR:PATH=${PYTHON_INCLUDE}
    -DPYTHON_LIBRARY:FILEPATH=${PYTHON_LIBRARY}
    # HDF5
    ${HDF5_ARGS}
    -DPARAVIEW_INSTALL_THIRD_PARTY_LIBRARIES:BOOL=OFF
    ${cdat_compiler_args}
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
  BUILD_COMMAND ${LIBRARY_PATH}=${cdat_EXTERNALS}/lib ${CMAKE_COMMAND} -DWORKING_DIR=<BINARY_DIR> -Dmake=$(MAKE) -P ${cdat_CMAKE_BINARY_DIR}/cdat_cmake_make_step.cmake
  INSTALL_COMMAND ${ParaView_install_command}
  DEPENDS ${ParaView_DEPENDENCIES}
)

configure_file(${cdat_CMAKE_SOURCE_DIR}/vtk_install_python_module.cmake.in
  ${cdat_CMAKE_BINARY_DIR}/vtk_install_python_module.cmake
  @ONLY)


 ExternalProject_Add_Step(ParaView InstallVTKPythonModule
    COMMAND ${CMAKE_COMMAND} -P ${cdat_CMAKE_BINARY_DIR}/vtk_install_python_module.cmake
    DEPENDEES install
    WORKING_DIRECTORY ${cdat_CMAKE_BINARY_DIR}
    )
