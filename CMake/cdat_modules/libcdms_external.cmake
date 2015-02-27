set(libcdms_source "${CMAKE_CURRENT_BINARY_DIR}/build/libcdms")
set(libcdms_install "${cdat_EXTERNALS}")
set(CONFIGURE_ARGS --srcdir=${libcdms_source}^^--enable-dap=^^--enable-drs=no^^--enable-hdf=no^^--enable-pp=yes^^--enable-ql=no^^--cache-file=/dev/null^^--prefix=${libcdms_install}^^--with-nclib=${cdat_EXTERNALS}/lib^^--with-ncinc=${cdat_EXTERNALS}/include^^--with-daplib=/lib^^--with-dapinc=/include^^--with-hdfinc=./include^^--with-hdflib=./lib^^--with-hdf5lib=${cdat_EXTERNALS}/lib^^--with-grib2lib=${cdat_EXTERNALS}/lib^^--with-jasperlib=${cdat_EXTERNALS}/lib^^--with-grib2inc=${cdat_EXTERNALS}/include^^--enable-grib2)
file(MAKE_DIRECTORY ${cdat_EXTERNALS}/man/man3)

if(DEFINED GIT_CMD_STR )
    message("[INFO] [libcdms] Installing ${nm} from ${GIT_CMD_STR}")
    include(GetGitRevisionDescription)
    set(URL_STR )
    set(URL_MD5_STR )
else()
    message("[INFO] [libcdms] Installed ${nm} from tarball ${LIBCDMS_GZ}")
    set(URL_STR URL ${LIBCDMS_URL}/${LIBCDMS_GZ})
    set(URL_MD5_STR URL_MD5 ${LIBCDMS_MD5})
    set(GIT_CMD_STR )
    set(GIT_TAG )
endif()

ExternalProject_Add(libcdms
  LIST_SEPARATOR ^^
  DOWNLOAD_DIR ${CDAT_PACKAGE_CACHE_DIR}
  SOURCE_DIR ${libcdms_source}
  INSTALL_DIR ${libcdms_install}
  ${URL_STR}
  ${URL_MD5_STR}
  ${GIT_CMD_STR}
  ${GIT_TAG}
  PATCH_COMMAND ${CMAKE_COMMAND} -E remove <SOURCE_DIR>/zconf.h
  BUILD_IN_SOURCE 1
  CONFIGURE_COMMAND ${CMAKE_COMMAND} -DCONFIGURE_ARGS=${CONFIGURE_ARGS} -DINSTALL_DIR=<INSTALL_DIR> -DWORKING_DIR=<SOURCE_DIR> -P ${cdat_CMAKE_BINARY_DIR}/cdat_configure_step.cmake
  BUILD_COMMAND ${CMAKE_MAKE_PROGRAM} -j1
  DEPENDS ${libcdms_deps}
  ${ep_log_options}
)
if (DEFINED GIT_CMD_STR)
  unset(GIT_CMD_STR)
endif()
