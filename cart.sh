source common.sh
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
PRINT "INSTALL NODEJS"
STAT
if [ $? -ne 0 ]; then
useradd roboshop
fi
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip"
cd /home/roboshop
rm -rf cart
unzip -o /tmp/cart.zip
mv cart-main cart
cd cart
npm install
if [ $? -eq 0 ]; then
echo -e "\e[33m SUCCESS NPM INSTALLED\e[0m"
fi
sed -i -e 's/REDIS_ENDPOINT/redis.devopsb69.online/' -e 's/CATALOGUE_ENDPOINT/catalogue.devopsb69.online/' systemd.service
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
systemctl daemon-reload
systemctl enable cart
systemctl restart cart