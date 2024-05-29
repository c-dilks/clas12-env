# clas12-env

### Overview
This repository is the environment setup for the non-GEANT portion of CLAS12 software builds.  The main branch is deployed on CVMFS and used for running software at JLab, on the Open Science Grid, or on any supported operating system with CVMFS access:

`/cvmfs/oasis.opensciencegrid.jlab.org/jlab/hallb/clas12/sw`

The documentation for just using these environment modules has so far been [maintained at this wiki](https://clasweb.jlab.org/wiki/index.php/CLAS12_Software_Environment_@_JLab).

Modulefiles's prerequisites and conflicts are used to help ensure a working environment with easy and flexible manipulations.

### Special Modules
These two modules are required by many other modules to provide some 3rd-patry C++ and Python dependencies.  No automated recipe currently exists for these installations, but they required only very standard procedures with no patching.
* system
  * sets `OSRELEASE` based on the operating system
  * sets `CLAS12_HOME` (only for convenience)
  * sets `PATH`, `LD_LIBRARY_PATH`, and `PKG_CONFIG_PATH` for these C++ libraries:
    * [fmt](https://github.com/fmtlib/fmt)
    * [yaml-cpp](https://github.com/jbeder/yaml-cpp)
* pymods
  * sets `PYTHONPATH` to pickup pip-installed python packages:
    * sqlalchemy
    * pymysql
    * ninja
    * jinja
    * meson
    * tzdata
    * numpy
    * pandas
    * (and their dependencies)
  

