# xxdeenxx_infra
xxdeenxx Infra repository

ДЗ №3

bastion_IP = 35.204.7.219
someinternalhost_IP = 10.164.0.3

Cпособ подключения к someinternalhost в одну команду
 Редактируем файл
 ~/.ssh/config

Host 35.204.7.219
    User appuser
    ForwardAgent yes

Проверить командой
ssh -tt <ip_bastion> ssh <ip_someinternalhost>


Cпособ подключения по алиасу someinternalhost
Редактируем файл
 ~/.ssh/config

Host someinternalhost
    HostName someinternalhost
    User appuser
    ForwardAgent yes
    IdentityFile ~/.ssh/appuser
    ProxyJump 35.204.7.219

Проверить командой
ssh someinternalhost


VPN

Cсылка на админку Pritunl
https://35-204-7-219.sslip.io/

логин/пароль
pritunl/pritunl


конфигурационный файл для подключения к vpn
cloud-bastion.ovpn

PIN 6214157507237678334670591556762


после подключения к vpn, удалось подключится к someinternalhost хосту по внутреннему ip
ssh 10.164.0.3

ДЗ №4

--Основное задание--

testapp_IP = 34.90.63.191
testapp_port = 9292

Добавлены скрипты:
install_ruby.sh     # Установка ruby
install_mongodb.sh  # Установка mongodb
deploy.sh           # Установка и запуск приложения

--Доп задание--

Добавлен скрипт startup_script.sh

Создать инстанс:
gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --metadata-from-file startup-script=./startup_script.sh \
  --restart-on-failure

Добавить правило:
gcloud compute firewall-rules create default-puma-server \
  --network default \
  --action allow \
  --direction ingress \
  --rules tcp:9292 \
  --source-ranges 0.0.0.0/0 \
  --priority 1000 \
  --target-tags puma-server

ДЗ №5

--Основное задание--

Подготовлен packer шаблон для содзания обрааза VM
packer/ubuntu16.json

В готовом образе VM настроены ruby и mongodb

--Доп задание--

Подготовлен packer шаблон для содзания обрааза VM
packer/immutable.json

В готовом образе VM все зависимости приложения и сам код приложения

Создать образ VM:
packer build -var-file variables.json immutable.json

Запустить виртуальную машину:
./config-scripts/startup_script.sh
