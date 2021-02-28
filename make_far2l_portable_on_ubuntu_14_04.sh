#!/bin/bash
mkdir ~
cd ~
rm -rf far2l
mkdir far2l
cd far2l
apt-get install -y wget gawk m4 libxerces-c-dev libuchardet-dev libssh-dev libssl-dev libnfs-dev libneon27-dev libarchive-dev libpcre3-dev cmake g++ git
wget http://mirrors.kernel.org/ubuntu/pool/universe/s/spdlog/libspdlog-dev_1.6-1_amd64.deb
sudo dpkg -i libspdlog-dev_1.6-1_amd64.deb
wget https://launchpad.net/~flixr/+archive/ubuntu/backports/+files/patchelf_0.9-1~ubuntu14.04.1~ppa1_amd64.deb
sudo dpkg -i patchelf_0.9-1~ubuntu14.04.1~ppa1_amd64.deb
git clone https://github.com/elfmz/far2l
cd far2l
mkdir build
cd build
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:george-edison55/cmake-3.x
sudo apt-get update
sudo apt-get install -y cmake
cmake -DUSEWX=no -DLEGACY=no -DCMAKE_BUILD_TYPE=Release ..
make -j$(nproc --all)
cd install
wget https://github.com/unxed/far2l-deb/raw/master/autonomizer.sh
chmod +x autonomizer.sh
./autonomizer.sh
rm lib/libc.so.6
rm lib/libdl.so.2
rm lib/libgcc_s.so.1
rm lib/libm.so.6
rm lib/libpthread.so.0
rm lib/libstdc++.so.6
rm lib/libresolv.so.2
rm lib/librt.so.1
cd ..
mv install far2l_portable
git clone https://github.com/megastep/makeself.git
makeself/makeself.sh far2l_portable far2l_portable.run far2l ./far2l
