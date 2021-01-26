#!/bin/bash


# A SHELL SCRIPT FOR INSTALLING FORTRAN TO A UBUNTU LINUX SYSTEM
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

# ASK FOR INSTALLATION CONFIRMATION
echo
echo This script installs Fortran to your system.
echo 
read -rsp $'Do you want to continue (y/n)?' -n 1 key
echo

if [ "$key" != "y" ]; then
    exit 0
fi

# install the build essential tools
echo
echo ...INSTALLING BUILD ESSENTIAL TOOLS...
sudo apt-get update
sudo apt-get --yes install build-essential
echo ...DONE...
echo

# install the GNU gfortran compiler
echo 
echo ...INSTALLING FORTRAN...
sudo apt-get --yes install gfortran
echo ...DONE...
echo

# install the GNU debugger
echo 
echo ...INSTALLING FORTRAN...
sudo apt-get --yes install gdb
echo ...DONE...
echo

# install gnuplot
echo 
echo ...INSTALLING GNUPLOT...
sudo apt-get --yes install gnuplot gnuplot-x11
echo ...DONE...
echo

# geany is the text editor and IDE for Fortran development
echo 
echo ...INSTALLING GEANY...
sudo apt-get --yes install geany
echo ...DONE...
echo

# this is to update the geany compiling and building options to our preferred configuration
echo
echo ...PATCHING GEANY...
mkdir -p ~/.config/geany/filedefs/
sudo cp ./src/filetypes.fortran ~/.config/geany/filedefs/filetypes.fortran
sudo cp ./src/geany.conf ~/.config/geany/geany.conf
sudo chmod 664 ~/.config/geany/filedefs/filetypes.fortran
sudo chown $USER:$USER -c ~/.config/geany/filedefs/filetypes.fortran
sudo chmod 664 ~/.config/geany/geany.conf
sudo chown $USER:$USER -c ~/.config/geany/geany.conf
echo ...DONE...
echo

# geany desktop icon
sudo cp /usr/share/applications/geany.desktop ~/Desktop
sudo chmod +x ~/Desktop/geany.desktop
sudo chown $USER:$USER -c ~/Desktop/geany.desktop

# now use gfortran to compile the toolbox
echo
echo ...COMPILING TOOLBOX... 
gfortran -c -Werror -Wno-unused -fimplicit-none -Wall -fcheck=bound,do -ffpe-trap=invalid,zero,overflow -frecursive -g ./src/toolbox.f90 -o toolbox_debug.o
gfortran -c -O3 ./src/toolbox.f90 -o toolbox.o
echo ...DONE... 
echo

# and copy the toolbox to the preferred working directory
echo
echo ...COPYING TO INCLUDE DIRECTORY...
sudo mkdir -p /usr/local/include
sudo mv toolbox.mod /usr/local/include/
sudo mv toolbox.o /usr/local/include/
sudo mv toolbox_debug.o /usr/local/include/
sudo cp ./src/toolbox_version.sh /usr/local/include/
echo ...DONE...
echo

# if everything ran correctly, at this point everything should be installed properly
echo  
echo ...INSTALLATION COMPLETED.
echo 
echo
echo In case you encountered any problem, check on www.ce-fortran.com for help.
echo
echo
read -p "Press RETURN to end..."
