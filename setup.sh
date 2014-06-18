#!/bin/bash - 
#===============================================================================
#
#   DESCRIPTION: Parse WPS, SBS and FMS files to reduce size and copy them to
#                   either the Sansa Fuze disk ( if plugged ) or the UI 
#                   simulator virtual disk
# 
#        AUTHOR: Sylvain Saubier (ResponSyS), saubiersylvain@gmail.com
#       CREATED: 06/03/2014 11:38
#===============================================================================

set -o nounset                              # Treat unset variables as an error

v_allFiles="./rockbox/*"
v_cmdDelHiddenFiles="find ./rockbox -name '[.]*' -type f -exec rm '{}' \;"
v_themeName="Unq"

v_wpsDir="./rockbox/wps/${v_themeName}/"

v_wpsIn="${v_themeName}-dev.wps"
v_wpsOut="./rockbox/wps/${v_themeName}.wps"

v_sbsIn="${v_themeName}-dev.sbs"
v_sbsOut="./rockbox/wps/${v_themeName}.sbs"

v_fmsIn="${v_themeName}-dev.fms"
v_fmsOut="./rockbox/wps/${v_themeName}.fms"

v_uiSimDir="../Source/sansafuze-sim-w32"
v_uiSimDiskDir="../Source/sansafuze-sim-w32/simdisk"

v_fuzeRootDir="/media/phen0m/0123-4567"

sed "s/ //g ; s/_SPACE_/ /g ; s/#.*$//g ; /^$/d ; /^\r/d" $v_wpsIn > $v_wpsOut
sed "s/ //g ; s/_SPACE_/ /g ; s/#.*$//g ; /^$/d ; /^\r/d" $v_sbsIn > $v_sbsOut
sed "s/ //g ; s/_SPACE_/ /g ; s/#.*$//g ; /^$/d ; /^\r/d" $v_fmsIn > $v_fmsOut

v_date="`date +'%F %r'`"
v_version="1.0"
sed "s/Date:.*$/Date: $v_date\r/ ; s/Version:.*$/Version: $v_version\r/" -i ./rockbox/themes/Unq.cfg

if test -d  $v_fuzeRootDir/; then
    rm -r                                       $v_fuzeRootDir/.rockbox/wps/$v_themeName/
    eval $v_cmdDelHiddenFiles
    cp -r --copy-contents  $v_allFiles          $v_fuzeRootDir/.rockbox/

    umount $v_fuzeRootDir && echo ::Sansa Fuze unmounted::
else
    rm -r                                       $v_uiSimDiskDir/.rockbox/wps/$v_themeName/
    eval $v_cmdDelHiddenFiles
    cp -r --copy-contents  $v_allFiles          $v_uiSimDiskDir/.rockbox/

    cd $v_uiSimDir/ && wine ./rockboxui.exe
fi

#   #rm -r                       $v_uiSimDiskDir/.rockbox/wps/$v_themeName/
#   cp      $v_wpsOut          $v_uiSimDiskDir/.rockbox/wps/
#   cp -r   $v_wpsDir           $v_uiSimDiskDir/.rockbox/wps/
exit
