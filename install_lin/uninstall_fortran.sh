#!/bin/bash


# A SHELL SCRIPT FOR UNINSTALLING FORTRAN FROM A UBUNTU LINUX SYSTEM
#
# This code is published under the GNU General Public License v3
#                         (https://www.gnu.org/licenses/gpl-3.0.en.html)
#
# Authors: Hans Fehr and Fabian Kindermann
#          contact@ce-fortran.com
#
# #VC# VERSION: 1.5  (06 January 2021)


# set the current directory as running directory
cd "$( cd "$( dirname "$0" )" && pwd )"

# ASK FOR UNINSTALLATION CONFIRMATION
echo
echo This script uninstalls Fortran/GNU Plot/Geany from your system.
echo 
read -rsp $'Do you want to continue (y/n)?' -n 1 key
echo

if [ "$key" != "y" ]; then
    exit 0
fi

# delete the toolbox
echo
echo ...REMOVE TOOLBOX...
sudo rm -f /usr/local/include/toolbox.mod
sudo rm -f /usr/local/include/toolbox.o
sudo rm -f /usr/local/include/toolbox_debug.o
sudo rm -f /usr/local/include/toolbox_version.sh
echo ...DONE...
echo

# uninstall geany
echo 
echo ...UNINSTALLING GEANY...
sudo apt-get --yes remove geany
sudo rm -r ~/.config/geany
echo ...DONE...
echo

# geany desktop icon
sudo rm -f ~/Desktop/geany.desktop

# uninstall gnuplot
echo 
echo ...UNINSTALLING GNUPLOT...
sudo apt-get --yes remove gnuplot gnuplot-x11
echo ...DONE...
echo

# uninstall the GNU gfortran compiler
echo 
echo ...UNINSTALLING FORTRAN...
sudo apt-get --yes remove gfortran
echo ...DONE...
echo

# install the build essential tools
echo
echo ...UNINSTALLING BUILD ESSENTIAL TOOLS...
sudo apt-get update
sudo apt-get --yes remove build-essential
echo ...DONE...
echo

# delete dependency packages
echo
echo ...DELETING DEPENDENT PACKAGES...
sudo apt-get --yes autoremove
echo ...DONE...
echo

# clean up configurations
echo
echo ...CLEANING UP CONFIGURATIONS...
sudo apt-get --yes clean
echo ...DONE...
echo

# if everything ran correctly, at this point everything should be installed properly
echo  
echo ...UNINSTALLATION PROCESS COMPLETED.
echo 
echo
echo In case you encountered any problem, check on www.ce-fortran.com for help.
echo
echo
read -p "Press RETURN to end..."
