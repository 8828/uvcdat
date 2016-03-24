set(OCGIS_SOURCE ${OCGIS_URL}/${OCGIS_GZ})
set(OCGIS_BRANCH next)
set(OCGIS_REPOSITORY ${GIT_PROTOCOL}github.com/NCPP/ocgis.git )

set(GIT_CMD_STR_OCGIS GIT_REPOSITORY ${OCGIS_REPOSITORY})
set(GIT_TAG GIT_TAG "${OCGIS_BRANCH}")

if (CDAT_BUILD_ALL)
  add_cdat_package(ocgis "" "" ON)
else()
  add_cdat_package(ocgis "" "" OFF)
endif()
