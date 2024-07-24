# clas12-env
[![Build Status](https://github.com/jeffersonlab/clas12-env/workflows/clas12-env-ci/badge.svg)](https://github.com/jeffersonlab/clas12-env/actions)

This is a [modulefile](https://modules.sourceforge.net/)-based environment setup for CLAS12 software.  Its main branch is deployed on CVMFS to support running CLAS12 software at JLab, on the Open Science Grid, or on any supported operating system with CVMFS access.

Note:
- The modulefiles and software builds for GEANT4 used in this environment are [documented separately](https://jeffersonlab.github.io/g4home) and can be used independently.
- This is *not* a build system!  If builds for a given operating system or compiler are not installed, these modulefiles will only print a warning (and Java components *should* still work).

## Quick Start

Only at JLab:

```erl
module use /scigroup/cvmfs/hallb/clas12/sw/modulefiles
```

or, from anywhere with CVMFS:

```erl
module use /cvmfs/oasis.opensciencegrid.org/jlab/hallb/clas12/sw/modulefiles
```

Then, to get the latest CLAS12 environment in one shot:

```erl
module load clas12
```

And then you can do stuff, e.g.:

```erl
ccdb -i
recon-util -h
gcc -o myana.exe -L$HIPO/lib -lhipo4 myana.c ...
clas12root -b -q -l mymacro.C
```

Note, the `module show` command prints what a given module will do to your environment, and usually includes a link to the documentation for the package it supports, e.g.,
```erl
ifarm> module show iguana/0.7.0
-------------------------------------------------------------------
module-whatis   https://github.com/jeffersonlab/iguana
prereq          hipo/4.1.0
setenv          IGUANA /path/to/iguana/0.7.0
etc ...
-------------------------------------------------------------------
```

## Special Modules
Most modules here just update one's environment for a single, particular software package, by adding that package's directories to some runtime search path(s).  The modules below are a bit different.  Note that `module show` will print what a given module will do to your environment.
* clas12
  * loads a bunch of other modules to provide a full CLAS12 environment in one shot
* tmpfs
  * gets various software, e.g., [apptainer](https://apptainer.org), to use a `/tmp` alternative, e.g., for when it's mounted noexec
  * *Note, coatjava versions prior to [10.1.0](https://github.com/JeffersonLab/coatjava/releases/tag/10.1.0) require this on el9 at JLab for SQLite support*
* sim
  * initializes [modulefiles from JLab's geant4 group](https://jeffersonlab.github.io/g4home/), e.g. `gemc`
* scicomp
  * initializes [modulefiles from JLab's scicomp group](https://jlab.servicenowservices.com/scicomp?id=kb_article_view&sysparm_article=KB0014671), e.g. `cernlib/2023`


And these two modules below are required by many other clas12 modules to provide some 3rd-party dependencies:
* system
  * sets `OSRELEASE` based on the operating system, via [this script](modulefiles/util/osrelease.py) (only for convenience)
  * sets `CLAS12_HOME` based on the filesystem location of these modulefiles (only for convenience)
  * sets `PATH`, `LD_LIBRARY_PATH`, and `PKG_CONFIG_PATH` for these C++ libraries:
    * [fmt](https://github.com/fmtlib/fmt)
    * [yaml-cpp](https://github.com/jbeder/yaml-cpp)
* pymods
  * sets `PYTHONPATH` to pickup these pip-installed packages (and their dependencies):
    * sqlalchemy
    * pymysql
    * ply
    * ninja
    * jinja
    * meson
    * pandas

## Details
  
### Directory Structure
The environment modulefiles here use a particular relative directory structure for the software builds they reference:

```boo
└── some "top" directory
    ├── modulefiles (this repository)
    ├── noarch (Java/Python/SQLite)
    ├── almalinux9-gcc11 (C++/Python/JDK)
    ├── fedora36-gcc12 (C++/Python/JDK)
    └── ...
```

And an example subset of the contents of an "osrelease" subdirectory:
```boo
└── almalinux9-gcc11
    ├── bin
    ├── lib
    ├── include
    └── local
        ├── ccdb
        │   └── 1.0
        ├── clas12root
        │   └── 1.8.4
        └── iguana
            ├── 0.6.0
            └── 0.7.0
```

### Utilities
The [`modulefiles/util`](modulefiles/util) directory contains both a module for [clas12-utilities](https://github.com/jeffersonlab/clas12-utilities) and some scripts used only during environment setup:
- [`osrelease.py`](modulefiles/util/osrelease.py) prints a string determined by the operating system and compiler, for defining installation paths
- [`functions.tcl`](modulefiles/util/functions.tcl) helper Tcl procedures used in various modulefiles
- [`siteconfig.tcl`](modulefiles/util/siteconfig.tcl) unused, a modulefile configuration for registering Tcl procedures
- [`.generic`](modulefiles/util/.generic) determines a version number from a modulefile's filename and loads its `.common`
