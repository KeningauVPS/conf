# install 
yum -y install squid nano
chkconfig squid on

# setting port ssh
sed -i '/Port 22/a Port 1080' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 443' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 109' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 143' /etc/ssh/sshd_config
sed -i '/Port 22/a Port 80' /etc/ssh/sshd_config
service sshd restart
chkconfig sshd on

# install squid
yum -y install squid
wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/lanunquota/conf/master/squid-centos.conf"
MYIP=`curl -s ifconfig.me`;
MYIP2="s/xxxxxxxxx/$MYIP/g";
sed -i $MYIP2 /etc/squid/squid.conf;
service squid restart
chkconfig squid on



# remove unused
yum -y remove sendmail;
yum -y remove httpd;
yum -y remove cyrus-sasl

# downlaod script
cd /usr/bin
curl https://raw.githubusercontent.com/lanunquota/conf/master/tQBgFJ5b > user-login.sh
curl https://raw.githubusercontent.com/lanunquota/conf/master/Bu3f4DPW > user-expired.sh
curl https://raw.githubusercontent.com/lanunquota/conf/master/X6p2b9nZ > user-add.sh
curl https://raw.githubusercontent.com/lanunquota/conf/master/rYEdJMeB > user-trial.sh
chmod +x /usr/bin/user-login.sh
chmod +x /usr/bin/user-expired.sh
chmod +x /usr/bin/user-add.sh
chmod +x /usr/bin/user-trial.sh

# finalisasi
service sshd restart
service squid restart

# info
clear
echo "Auto Installer by PerantauSepi (izam-lukman)" | tee log-install.txt
echo "===============================================" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Service"  | tee -a log-install.txt
echo "-------"  | tee -a log-install.txt
echo "OpenSSH  : 1080, 109, 143, 443, 80"  | tee -a log-install.txt
echo "Squid3   : 8080 (limit to IP SSH)"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Script"  | tee -a log-install.txt
echo "------"  | tee -a log-install.txt
echo "./user-login.sh"  | tee -a log-install.txt
echo "./user-expired.sh"  | tee -a log-install.txt
echo "./user-add.sh"  | tee -a log-install.txt
echo "./user-trial.sh"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "==============================================="  | tee -a log-install.txt
