#!/bin/bash

# run in the directory next to the archive.
# this will also install the lv runtime.

#Download and install LV RTE
wget "http://download.ni.com/support/softlib/labview/labview_runtime/2019 SP1/LabVIEW2019SP1RTE_Linux.tgz"
tar -zxvf LabVIEW2019SP1RTE_Linux.tgz
./LabVIEW2019SP1RTE_Linux/INSTALL

#Now our app.
tar -zxvf exnics.tar.gz -C /opt
cd /opt/exnics
./create_folder.sh
cp exnics.service /usr/lib/systemd/system/exnics.service
useradd exnics -g exnics
chgrp -R exnics /opt/exnics
systemctl enable exnics.service && systemctl start exnics.service

#Configure firewall
sudo firewall-cmd --zone=public --add-port=60000-65535/udp --permanent
