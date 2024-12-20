
# load our file of utility functions:
source [file normalize [exec dirname [dict get [info frame 0] file]]]/functions.tcl

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

# list all site-specific procedures to expose to modulefile and modulerc
# interpreter contexts:
set g_siteProcsToExposeToItrp [list home osrelease warndir]


