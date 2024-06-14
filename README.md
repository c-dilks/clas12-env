# clas12-env
This is a [modulefile](https://modules.sourceforge.net/)-based environment setup for CLAS12 software.  The main branch is deployed on CVMFS for running software at JLab, on the Open Science Grid, or on any supported operating system with CVMFS access.

- *The modulefiles and software builds for GEANT4 used in this environment are [documented separately](https://geant4.jlab.org/node/1) and can be used independently.*
- *The shell `setup.*` files here are deprecated and only for backward compatibility with previous environment setups.*

## Quick Start

Only at JLab:

`module use /scigroup/cvmfs/hallb/clas12/sw/modulefiles`

or, from anywhere with CVMFS:

`module use /cvmfs/oasis.opensciencegrid.org/jlab/hallb/clas12/sw/modulefiles`

Then, to get the full CLAS12 "production" environment in one shot:

`module load clas12`

And then you could run stuff, e.g.:

`clas12root -b -q -l mymacro.C`

Note, most modules provide a link to the documentation for the package they support via the `module show` command.

## Special Modules
Most modules here just update one's environment for a single, particular software package, by adding that package's directories to some runtime search path(s).  The modules below are a bit different.  Note that `module show` will print what a given module will do to your environment.
* clas12
  * loads a bunch of other modules to provide a full CLAS12 environment in one shot
* tmpfs
  * gets various software, e.g., apptainer, to use a `/tmp` alternative, i.e., for when it's mounted noexec
* geant4
  * initializes [modulefiles from JLab's geant4 group](https://geant4.jlab.org/node/1), e.g. `gemc`
* scicomp
  * initializes [modulefiles from JLab's scicomp group](https://jlab.servicenowservices.com/scicomp?id=kb_article_view&sysparm_article=KB0014671), e.g. `cernlib/2023`


And these two modules below are required by many other clas12 modules to provide some 3rd-party dependencies:
* system
  * sets `OSRELEASE` based on the operating system (via [this script](modulefiles/util/osrelease.py))
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
    * numpy
    * pandas

## Details
  
### Build Structure
The environment modulefiles here are relocatable by using a particular *relative* directory structure for the software builds they reference:

- some "top" directory
  - [`modulefiles`](modulefiles) (this repository)
  - `noarch` (data/shell/python)
  - `linux-64` (jdks)
  - [[osrelease#1]](modulefiles/util/osrelease.py), e.g. `almalinux9-gcc11`
  - [[osrelease#2]](modulefiles/util/osrelease.py), e.g. `rhel9-gcc11`

### Utilities
The [`modulefiles/util`](modulefiles/util) directory is both a module for [clas12-utilities](https://github.com/jeffersonlab/clas12-utilities) and a container for some general utilities used during environment setup:
- [`osrelease.py`](modulefiles/util/osrelease.py)
- [`functions.tcl`](modulefiles/util/functions.tcl)
- [`.generic`](modulefiles/util/.generic)
