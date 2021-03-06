import cdms2
import numpy
import time

# All flags are set to OFF for parallel writing
# ----------------------------------------------

cdms2.setNetcdfClassicFlag(0)
cdms2.setNetcdfShuffleFlag(0)
cdms2.setNetcdfDeflateFlag(0)
cdms2.setNetcdfDeflateLevelFlag(0)
cdms2.setNetcdfUseParallelFlag(1)
sz = cdms2.getMpiSize()
rk = cdms2.getMpiRank()

# Create a 2D array
# -----------------
lat = 181
lon = 361
a=numpy.ma.ones((lat,lon),dtype=numpy.float32)

# Create 1 degree grid of the world
# -----------------------------------
grid=cdms2.grid.createUniformGrid(-90, 181, 1, 0, 361, 1, order="yx")


#pdb.set_trace()
f=cdms2.open("test_mpi_write_2.nc","w")


# Create variables for each node
# ------------------------------
var=[]
for i in range(sz):
    a.id = "var_test_mpi_"+str(i)
    if rk == 0:
	print a.id
    Field=cdms2.MV2.array(a)
    var.append(f.createVariableCopy(Field,axes=grid.getAxisList(), grid=grid))

# Now rewrite the time slice accross processors
#----------------------------------------------
for k in range(sz):
   V=var[k]
   for j in range(rk,lat,sz):
         V[j] = a[j].filled()*rk
f.close()
