# clas12-env

### Overview
This is a [modulefile](https://modules.sourceforge.net/)-based environment setup for CLAS12 software.  *Note, the modulefiles and software builds for GEANT4/GEMC used in this environment are [documented separately](https://geant4.jlab.org/node/1) and can be used independently.*

### In Use
The main branch is deployed on CVMFS and used for running software at JLab, on the Open Science Grid, or on any supported operating system with CVMFS access:

`/cvmfs/oasis.opensciencegrid.jlab.org/jlab/hallb/clas12/sw`

The documentation for just using these environment modules has so far been [maintained at this wiki](https://clasweb.jlab.org/wiki/index.php/CLAS12_Software_Environment_@_JLab).

### Special Modules
Most modules here just update one's environment for a single, particular software package, by adding that package's directory to some runtime executable/library search paths.  The modules below are a bit different.  Remember that `module show` will print what a given module will do to your environment.
* clas12
  * loads a bunch of other modules to provide a full CLAS12 environment in one shot
* geant4
  * adds [modulefiles from JLab's geant4 group](https://geant4.jlab.org/node/1), e.g. `gemc`, to the search path
* scicomp
  * adds [modulefiles from JLab's scicomp group](https://jlab.servicenowservices.com/scicomp?id=kb_article_view&sysparm_article=KB0014671), e.g. `cernlib/2023`, to the search path
* tmpfs
  * sets envionment variables to get various software (maven, apptainer, java, things that honor `TMPDIR`, etc.) to use a `/tmp` alternative, e.g. for when it's mounted noexec

And these two modules below are required by many other clas12 modules to provide some 3rd-party dependencies:
* system
  * sets `OSRELEASE` based on the operating system (via [this script](util/osrelease.py))
  * sets `CLAS12_HOME` (only for convenience)
  * sets `PATH`, `LD_LIBRARY_PATH`, and `PKG_CONFIG_PATH` for these C++ libraries:
    * [fmt](https://github.com/fmtlib/fmt)
    * [yaml-cpp](https://github.com/jbeder/yaml-cpp)
* pymods
  * sets `PYTHONPATH` to pickup these pip-installed python packages (and their dependencies):
    * sqlalchemy
    * pymysql
    * ninja
    * jinja
    * meson
    * tzdata
    * numpy
    * pandas

### Build Structure
The environment modulefiles in this repository follow a particular directory structure for the software builds it references:

- [modulefiles](modulefiles)
- noarch (data/shell/python)
- linux-64 (jdks)
- [osrelease#1](util/osrelease.py), e.g. `almalinux9-gcc11`
- [osrelease#2](util/osrelease.py), e.g. `rhel9-gcc11`
- ...

(Is there a web-based CVMFS browser we could link to?)
