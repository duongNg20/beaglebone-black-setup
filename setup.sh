#!/bin/bash

echo "[act] create /opt and /opt/qt"
mkdir /opt
mkdir /opt/qt

echo "[act] copy qt library"
cp -v -r $PWD/bbb_metadata/opt/qt /opt/

echo "[act] copy column light program"
cp -v -r $PWD/bbb_metadata/opt/ColBBB_App_QML /opt
  
echo "[act] disable GDM"
systemctl disable gdm.service

echo "[act] copy prevent HDMI to sleep script"
cp -v $PWD/bbb_metadata/xorg.conf /etc/X11/xorg.conf

echo "[act] copy startup script"
cp -v $PWD/bbb_metadata/col_script.sh /usr/bin
chmod u+x /usr/bin/col_script.sh

echo "[act] copy startup service"
cp -v $PWD/bbb_metadata/col_script.service /lib/systemd

echo "[act] setup systemd service"
cd /etc/systemd/system
ln /lib/systemd/col_script.service col_script.service
systemctl daemon-reload
systemctl start col_script.service
systemctl enable col_script.service
#shutdown -r now

echo "[act] Done."
