COMPONENT=rabbitmq
source common.sh
RABBIT_APP_USER_PASSWORD=$1

if [ -z "$1" ]; then
  echo "input password is needed"
  exit
  fi

PRINT "download repo file"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>{LOG}
STAT $?

PRINT "erlang installation"
yum install erlang -y &>>{LOG}
STAT $?

PRINT "rabbitmq repo"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>{LOG}
STAT $?

PRINT "install rabbitmq"
yum install rabbitmq-server -y &>>{LOG}
STAT $?

PRINT "Enable RabbitMQ Service"
systemctl enable rabbitmq-server   &>>$LOG
STAT $?


PRINT "Start RabbitMQ Service"
systemctl start rabbitmq-server  &>>$LOG
STAT $?

PRINT "rabbitmq user"
rabbitmqctl add_user roboshop ${RABBIT_APP_USER_PASSWORD} &>>{LOG}
STAT $?

PRINT "user tag"
rabbitmqctl set_user_tags roboshop administrator &>>{LOG}
STAT $?

PRINT "permissions"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>{LOG}
STAT $?