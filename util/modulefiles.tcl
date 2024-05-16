
# append site-specific procedures referenced in the g_siteProcsToExposeToItrp
# variable defined below to the list of procedures exposed in the modulefile
# and modulerc evaluation interpreters
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

# Define here site-specific procedures that should be exposed to modulefile
# and modulerc interpreter contexts

# Get an environment variable, with a default if it doesn't exist.
proc getenv {name default} {
    global env
    if { [ info exists env($name) ] } {
        return $env($name)
    }
    return $default
}

# Get version number from a path-like environment variable, assuming
# the basename is a version number and with a default of "$k".
proc getvenv {path} {
    return [ exec basename [getenv $path \$$path] ] 
}

# Get the full, normlized path to the directory containing this tcl script:
proc home {} {
    set x [ dict get [info frame 0] file ]
    return [ file normalize [exec dirname $x]/.. ]
}

# Get the $OSRELEASE environment variable if it exists, else
# run our script to get what it will become upon loading modules:
proc osrelease {} {
    return [ getenv OSRELEASE [exec [home]/util/osrelease.py] ]
}

# list all site-specific procedures to expose to modulefile and modulerc
# interpreter contexts
set g_siteProcsToExposeToItrp [list getenv getvenv home osrelease]

