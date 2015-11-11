set(PYEXPECT_MAJOR 4)
set(PYEXPECT_MINOR 0)
set(PYEXPECT_PATCH 1)
set(PYEXPECT_VERSION ${PYEXPECT_MAJOR}.${PYEXPECT_MINOR}.${PYEXPECT_PATCH})
set(PYEXPECT_URL ${LLNL_URL} )
set(PYEXPECT_GZ pyexpect-${PYEXPECT_VERSION}.tar.gz)
set(PYEXPECT_MD5 2bd260f7f2159f9bcab373721736d526)
set(PYEXPECT_SOURCE ${PYEXPECT_URL}/${PYEXPECT_GZ})

add_cdat_package(IPYTHON "" "" ON)
