#!/bin/sh

# run in the directory next to the archive.
# this will also install the lv runtime.

#Download and install LV RTE
read -p "Install LabVIEW RTE? " -n 1 -r
echo    # (optional) move to a new line
if [[  $REPLY =~ ^[Yy]$ ]]
then
    wget "http://download.ni.com/support/softlib/labview/labview_runtime/2019 SP1/LabVIEW2019SP1RTE_Linux.tgz"
    mkdir LabVIEWRTE
    tar -zxvf LabVIEW2019SP1RTE_Linux.tgz -C ./LabVIEWRTE
    ./LabVIEWRTE/INSTALL

fi

#Now our app.
tar -zxvf exnics.tar.gz -C /opt
/opt/exnics/create_folder.sh

cp /opt/exnics/exnics.service /etc/systemd/system/exnics.service
useradd exnics -g exnics
chgrp -R exnics /opt/exnics
systemctl daemon-reload
systemctl enable exnics.service && systemctl start exnics.service

#Configure firewall
sudo firewall-cmd --zone=public --add-port=30000-65535/udp --permanent

