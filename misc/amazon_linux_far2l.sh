
# install far2l on Amazon Linux 2018.03

mkdir far2l_temp
cd far2l_temp

# installing basic tools

sudo yum install gcc gcc-c++ autoconf automake git glib2-devel openssl-devel

# installing fresh cmake

sudo yum remove cmake

wget https://github.com/Kitware/CMake/releases/download/v3.15.5/cmake-3.15.5.tar.gz
tar -xvzf cmake-3.15.5.tar.gz
cd cmake-3.15.5
./bootstrap
make
sudo make install
cd ..

# installing libssh for sftp/ssh support in netrocks
# needed 0.8 branch to build with default openssl on Amazon Linux 2018.03

wget https://www.libssh.org/files/0.8/libssh-0.8.7.tar.xz
tar -xvJf libssh-0.8.7.tar.xz
cd libssh-0.8.7
mkdir build
cd build
cmake -DUNIT_TESTING=OFF -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Debug ..
make
sudo make install
cd ../..

# building Far2l

mkdir far2l
cd far2l
git clone https://github.com/elfmz/far2l

mkdir build
cd build
cmake -DUSEWX=no -DCMAKE_BUILD_TYPE=Debug ../far2l
make
sudo make install

cd ../../..
