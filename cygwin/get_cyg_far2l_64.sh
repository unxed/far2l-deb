#!/bin/bash
mkdir /opt
cd /opt
rm -rf far2l
wget https://github.com/unxed/far2l-deb/raw/master/cygwin/far2l_cyg_64.tgz
tar -xzf far2l_cyg_64.tgz
rm -rf far2l_cyg_64.tgz
echo "#!/bin/bash" > /bin/far2l
echo "ps | grep xinit || startxwin >/dev/null 2>&1 & sleep 5" >> /bin/far2l
echo "DISPLAY=:0.0 /opt/far2l/far2l" >> /bin/far2l
chmod +x /bin/far2l
