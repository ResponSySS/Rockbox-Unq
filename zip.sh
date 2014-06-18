#!/bin/bash - 
#===============================================================================
#
#          FILE: zip.sh
# 
#         USAGE: ./zip.sh 
# 
#   DESCRIPTION: Make a zip archive for Rockbox theme to be distributed.
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Sylvain Saubier (ResponSyS), saubiersylvain@gmail.com
#  ORGANIZATION: 
#       CREATED: 06/17/2014 14:21
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

if test -z "`which zip`"; then
    exit
fi

v_themeName="Unq"
v_zipName=${v_themeName}.zip

test -f $v_zipName && rm $v_zipName
cp -r ./rockbox ./.rockbox && zip $v_zipName -r -m ./.rockbox

exit
