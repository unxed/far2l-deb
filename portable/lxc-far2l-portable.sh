#!/bin/bash
sudo apt install -y lxc
# cleanup
sudo lxc-stop -n far2l
sudo lxc-destroy -n far2l
sudo rm -rf ~/far2l_portable.run
# here we go
sudo lxc-create -t download -n far2l -- --keyserver hkp://p80.pool.sks-keyservers.net:80 -d ubuntu -r trusty -a amd64
sudo lxc-start -n far2l -d
sleep 2
sudo lxc-attach -n far2l -- sudo apt install -y wget
sudo lxc-attach -n far2l -- wget https://github.com/unxed/far2l-deb/raw/master/portable/make_far2l_portable_on_ubuntu_14_04.sh
sudo lxc-attach -n far2l -- chmod +x make_far2l_portable_on_ubuntu_14_04.sh
sudo lxc-attach -n far2l -- ./make_far2l_portable_on_ubuntu_14_04.sh
sudo chmod +r -R /var/lib/lxc/far2l
sudo cp /var/lib/lxc/far2l/rootfs/home/$LOGNAME/far2l/far2l/build/far2l_portable.run ~
sudo lxc-stop -n far2l
sudo lxc-destroy -n far2l
