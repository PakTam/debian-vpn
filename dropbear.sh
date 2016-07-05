#!/bin/bash
# install dropbear

apt-get install -y dropbear

sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=443/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS=""/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
service ssh restart
service dropbear restart

#
cd

wget -O dropmon "https://raw.githubusercontent.com/PakTam/debianos7/master/dropmon.sh"
wget -O userlogin.sh "https://raw.githubusercontent.com/PakTam/debianos7/master/userlogin.sh"
wget -O userexpired.sh "https://raw.githubusercontent.com/PakTam/debianos7/master/userexpired.sh"
wget -O userlimit.sh "https://raw.githubusercontent.com/PakTam/debianos7/master/userlimit.sh"
wget -O expire.sh "https://raw.githubusercontent.com/PakTam/debianos7/master/expire.sh"
wget -O autokill.sh "https://raw.githubusercontent.com/PakTam/debianos7/master/autokill.sh"
echo "@reboot root /root/userlimit.sh" > /etc/cron.d/userlimit
echo "* * * * * service dropbear restart" > /etc/cron.d/dropbear
echo "@reboot root /root/autokill.sh" > /etc/cron.d/autokill
sed -i '$ i\screen -AmdS check /root/autokill.sh' /etc/rc.local


chmod +x userlogin.sh
chmod +x userexpired.sh
chmod +x userlimit.sh
chmod +x autokill.sh
chmod +x dropmon
