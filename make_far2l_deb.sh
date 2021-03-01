#!/bin/bash
sudo apt install -y libwxgtk3.0-dev
sudo apt install -y libwxgtk3.0-gtk3-dev
sudo apt install -y libneon27-dev
sudo apt-get install -y git cmake g++ gawk m4 libuchardet-dev libxerces-c-dev libspdlog-dev libpcre3-dev libarchive-dev libssl-dev libssh-dev libsmbclient-dev libnfs-dev
rm -rf far2l.deb far2l_`getconf LONG_BIT`.deb
rm -rf far2l
mkdir far2l
cd far2l
git clone https://github.com/elfmz/far2l
cd far2l
sed -i 's/\.smarty/\.tpl/g' colorer/configs/base/hrc/proto.hrc
wget https://raw.githubusercontent.com/unxed/far2l-deb/master/misc/smarty.hrc -O colorer/configs/base/hrc/inet/smarty.hrc
cd ..
mkdir build
cd build
cmake -DUSEWX=yes -DLEGACY=yes -DCMAKE_BUILD_TYPE=Release ../far2l
make -j$(nproc --all)
MACHINE_TYPE=`uname -m`
if [ ${MACHINE_TYPE} == 'x86_64' ]; then
    DEB_ARCH="amd64"
elif [ ${MACHINE_TYPE} == 'aarch64' ]; then
    DEB_ARCH="arm64"
elif [ ${MACHINE_TYPE} == 'armv7l' ]; then
    DEB_ARCH="armhf"
else
    DEB_ARCH="i386"
fi
rm -rf far2l/deb
rm -f far2l_`getconf LONG_BIT`.deb
cd far2l
mkdir deb
mkdir deb/far2l
mkdir deb/far2l/DEBIAN
echo "Package: far2l" > deb/far2l/DEBIAN/control
echo "Version: 2.2" >> deb/far2l/DEBIAN/control
MACHINE_TYPE=`uname -m`
if [ ${MACHINE_TYPE} == 'x86_64' ]; then
    echo "Architecture: amd64" >> deb/far2l/DEBIAN/control
else
    echo "Architecture: i386" >> deb/far2l/DEBIAN/control
fi
echo "Maintainer: root <root@localhost>" >> deb/far2l/DEBIAN/control
echo "Priority: extra" >> deb/far2l/DEBIAN/control
echo "Depends: libwxgtk3.0-dev | libwxgtk3.0-gtk3-dev, libuchardet-dev, libpcre3-dev, libarchive-dev, libxerces-c-dev, libspdlog-dev, libssl-dev, libssh-dev, libsmbclient-dev, libnfs-dev, libneon27-dev" >> deb/far2l/DEBIAN/control
echo "Description: Linux port of FAR v2" >> deb/far2l/DEBIAN/control
echo " https://github.com/elfmz/far2l" >> deb/far2l/DEBIAN/control
echo " ." >> deb/far2l/DEBIAN/control
echo " License: GNU/GPLv2" >> deb/far2l/DEBIAN/control
echo " ." >> deb/far2l/DEBIAN/control
echo " Used code from projects:" >> deb/far2l/DEBIAN/control
echo " FAR for Windows" >> deb/far2l/DEBIAN/control
echo " Wine" >> deb/far2l/DEBIAN/control
echo " ANSICON" >> deb/far2l/DEBIAN/control
echo " Portable UnRAR" >> deb/far2l/DEBIAN/control
echo " 7z ANSI-C Decoder" >> deb/far2l/DEBIAN/control
echo " ." >> deb/far2l/DEBIAN/control
mkdir deb/far2l/usr
mkdir deb/far2l/usr/bin
mkdir deb/far2l/usr/share
mkdir deb/far2l/usr/share/applications
echo "[Desktop Entry]" > deb/far2l/usr/share/applications/far2l.desktop
echo "Type=Application" >> deb/far2l/usr/share/applications/far2l.desktop
echo "Name=far2l wx" >> deb/far2l/usr/share/applications/far2l.desktop
echo "GenericName=far2l wx" >> deb/far2l/usr/share/applications/far2l.desktop
echo "Comment=File and archive manager" >> deb/far2l/usr/share/applications/far2l.desktop
echo "Exec=far2l" >> deb/far2l/usr/share/applications/far2l.desktop
echo "Terminal=false" >> deb/far2l/usr/share/applications/far2l.desktop
echo "Categories=Utility;FileManager;" >> deb/far2l/usr/share/applications/far2l.desktop
echo "Icon=far2l.svg" >> deb/far2l/usr/share/applications/far2l.desktop
echo "StartupNotify=true" >> deb/far2l/usr/share/applications/far2l.desktop
mkdir deb/far2l/usr/share
mkdir deb/far2l/usr/share/icons
mkdir deb/far2l/usr/share/icons/hicolor
mkdir deb/far2l/usr/share/icons/hicolor/scalable
mkdir deb/far2l/usr/share/icons/hicolor/scalable/apps
cp far2l/far2l/DE/icons/far2l.svg deb/far2l/usr/share/icons/hicolor/scalable/apps/far2l.svg
mkdir deb/far2l/usr/lib
mkdir deb/far2l/usr/lib/far2l
cp -R build/install/* deb/far2l/usr/lib/far2l/
cd deb/far2l/usr/bin/
ln -s ../lib/far2l/far2l far2l
cd ../../..
fakeroot dpkg-deb --build far2l
cp far2l.deb ../..
cd ../..
#rm -rf far2l
rm -rf far2l/deb
rm -rf far2l_${DEB_ARCH}.deb
mv far2l.deb far2l_${DEB_ARCH}.deb
