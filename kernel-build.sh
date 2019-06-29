#! /bin/bash

clear
#download the latest stable tarball:
echo -e "\033[1;5;7m  1/7 - downloading the latest stable tarball \033[m"
wget eval $(curl -s https://www.kernel.org | grep -A1 latest_link | tail -n1 | egrep -o '[^"]+' | egrep 'tar')
paplay /usr/share/sounds/freedesktop/stereo/complete.oga
sleep 1s
clear

#download it's hash code
echo -e "\033[1;5;7m  2/7 - downloading the hash file \033[m"
kernel_tarball_file_link="wget $(curl -s https://www.kernel.org | grep -A1 latest_link | tail -n1 | egrep -o '[^"]+' | egrep 'tar')"
kernel_hash_file_link=eval ${kernel_tarball_file_link::-2}sign
paplay /usr/share/sounds/freedesktop/stereo/complete.oga
sleep 1s
clear

#decompress the archive
echo -e "\033[1;5;7m  3/7 - decompressing the archive \033[m"
xz -dq linux-*.tar.xz
paplay /usr/share/sounds/freedesktop/stereo/complete.oga
sleep 1s
clear

#verify the tarball
echo -e "\033[1;5;7m  4/7 - verifying the contents \033[m"
gpg --verify linux-*.tar.sign
paplay /usr/share/sounds/freedesktop/stereo/complete.oga
sleep 1s
clear

#extract the tarball
echo -e "\033[1;5;7m  5/7 - extracting the tarball \033[m"
tar xf linux-*.tar
paplay /usr/share/sounds/freedesktop/stereo/complete.oga
sleep 1s
clear

#generate menuconfig
echo -e "\033[1;5;7m  6/7 - generating the kernel configuration \033[m"
pushd "linux-$(curl -s https://www.kernel.org | grep -A1 latest_link | tail -n1 | egrep -o '>[^<]+' | egrep -o '[^>]+')"
make localyesconfig
paplay /usr/share/sounds/freedesktop/stereo/complete.oga
sleep 1s
clear

#build the distro specific packages
echo -e "\033[1;5;7m  7/7 - building the kernel \033[m"
make -j3 deb-pkg
paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga
sleep 1s
clear

#done
echo -e "\033[1;5;7m  BUILDING PROCESS FINISHED \033[m"
