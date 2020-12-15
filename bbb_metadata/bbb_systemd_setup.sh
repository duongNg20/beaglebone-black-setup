# !/bin/bash

# disable GDM
echo `systemctl disable gdm.service`

# setting systemd service
echo `cd /etc/systemd/system`
echo `ln /lib/systemd/col_script.service col_script.service`
echo `systemctl daemon-reload`
echo `systemctl start col_script.service`
echo ` systemctl enable col_script.service`
