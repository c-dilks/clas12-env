
# append site-specific procedures referenced in the g_siteProcsToExposeToItrp
# variable defined below to the list of procedures exposed in the modulefile
# and modulerc evaluation interpreters:
proc addSiteProcsToItrpAliasList {itrpaliasvname keyname args} {
   # ensure this proc is only called once at itrpaliasvname initialization
   trace remove variable $itrpaliasvname write addSiteProcsToItrpAliasList
   upvar #0 $itrpaliasvname itrpaliasv
   # register each site-specific procedure
   foreach procname $::g_siteProcsToExposeToItrp {
      if {$keyname ne {}} {
         set itrpaliasv($procname) $procname
      } else {
         lappend itrpaliasv $procname $procname
      }
   }
}
trace add variable ::g_modfileBaseAliases write addSiteProcsToItrpAliasList
trace add variable ::g_modrcAliases write addSiteProcsToItrpAliasList

# define here site-specific procedures that should be exposed to modulefile
# and modulerc interpreter contexts:

# get an environment variable, with a default if it doesn't exist:
proc getenv {name default} {
    global env
    if { [ info exists env($name) ] } {
        return $env($name)
    }
    return $default
}

# get the basename of the value of a path-like environment variable, which
# will commonly be a version number, with a default of "$name":
proc getvenv {name} {
    return [ exec basename [getenv $name \$$name] ] 
}

# get the full, normlized path to the directory containing this tcl script:
proc home {} {
    set x [ dict get [info frame 0] file ]
    return [ file normalize [exec dirname $x]/.. ]
}

# get the $OSRELEASE environment variable if it exists, else
# run our script to get what it will become upon loading modules:
# (Note, we don't use our getenv here for performance reasons.)
proc osrelease {} {
    global env
    if { [ info exists env(OSRELEASE) ] } {
        return $env(OSRELEASE)
    }
    return [ exec [home]/util/osrelease.py ]
}

# print a warning message if a path doesn't exist:
proc warndir {path msg} {
    if [module-info mode load] {
        if {! [file isdirectory $path ] } {
            puts stderr "\033\[1;33mWARNING:\033\[0m  $msg"
        }
    }
}

# list all site-specific procedures to expose to modulefile and modulerc
# interpreter contexts:
set g_siteProcsToExposeToItrp [list getenv getvenv home osrelease warndir]

