import sys,os
target_prefix = sys.prefix
for i in range(len(sys.argv)):
    a = sys.argv[i]
    if a=='--prefix':
        target_prefix=sys.argv[i+1]
    sp = a.split("--prefix=")
    if len(sp)==2:
        target_prefix=sp[1]
sys.path.insert(0,os.path.join(target_prefix,'lib','python%i.%i' % sys.version_info[:2],'site-packages')) 
from numpy.distutils.core import Extension
import sys
sources = """
Src/gaqd.f  Src/rgrd1.f  Src/rgrd1u.f  Src/rgrd2.f  Src/rgrd2u.f  Src/rgrd3.f  Src/rgrd3u.f  Src/rgrd4.f  Src/rgrd4u.f
""".split()

extra_link_args=[]
if sys.platform=='darwin':
    extra_link_args = ['-bundle','-bundle_loader '+sys.prefix+'/bin/python']
ext1 = Extension(name = 'regridpack',
                 extra_link_args=extra_link_args,
                 sources = ['Src/regridpack.pyf',]+sources)

if __name__ == "__main__":
    from numpy.distutils.core import setup
    setup(name = 'adamsregrid',
          ext_modules = [ext1,],
          packages = ['adamsregrid'],
          package_dir = {'adamsregrid': 'Lib',
                     },
          )
