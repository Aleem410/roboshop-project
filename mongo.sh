curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo
yum install -y mongodb-org
if [ $? -eq 0 ]; then
echo -e "\e[34m SUCCESS INSTALLED\e[0m"
else
echo FAILURE
fi

systemctl enable mongod
systemctl start mongod