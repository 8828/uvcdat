set(R_MAJOR_SRC 3)
set(R_MINOR_SRC 2)
set(R_PATCH_SRC 2)
set(R_URL ${LLNL_URL})
set(R_GZ R-${R_MAJOR_SRC}.${R_MINOR_SRC}.${R_PATCH_SRC}.tar.gz)
set(R_MD5 57cef5c2e210a5454da1979562a10e5b)
set(R_SOURCE ${R_URL}/${R_GZ})

set (nm R)
string(TOUPPER ${nm} uc_nm)
set(${uc_nm}_VERSION ${${nm}_MAJOR_SRC}.${${nm}_MINOR_SRC}.${${nm}_PATCH_SRC})
add_cdat_package_dependent(R "" "Build R" ${CDAT_BUILD_ALL}
                           "CDAT_BUILD_GUI" OFF)
