# xxdeenxx_infra
xxdeenxx Infra repository

ДЗ №5

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

ДЗ №6

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
gcloud compute firewall-rules create default-ssh-server \
  --network default \
  --action allow \
  --direction ingress \
  --rules tcp:22 \
  --source-ranges 0.0.0.0/0 \
  --priority 1000 \
  --target-tags puma-server

ДЗ №7

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

ДЗ №8

--Основное задание--

Настроены конфигурационные файлы terraform.
Командой "terraform apply" создаётся инстанст с полность рабочим приложением

--Доп задание--

1. добавлены 2 пользователя в метаданные проекта.
2. через веб интерфейс добавлен пользователь appuser_web.
   После выполнения команды "terraform apply" пользователь удаляется,
   остаются только пользователи описаные в конфигурации terraform.
3. Для настройки балансировщика использовался модуль "gce-lb-http"
4. Добавлна переменная "count" через неё указывается количество инстансов

ДЗ №9

--Основное задание--

1. Настроил модуль "storage-bucket для создания бакета

--Доп задание--

1. Нстроил хранение стейт файла в удаленном бекенде. Отдельно для каждого окружения stage и prod


ДЗ №10

--Основное задание--

1. Знакомство с Ansible
    - установка
    - настройка
    - написание простейшего плейбука
    - настройка inventory через ansible.cfg

--Доп задание--

1. Создал скрипт который генерирует динамический инвентори в
     JSON  формате
pcpa

ДЗ №11

--Основное задание--

1. Знакомство с Ansible
    - Создал  главный плейбук, который включает в себя
      - import_playbook: db.yml
      - import_playbook: app.yml
      - import_playbook: deploy.yml

--Доп задание--

1. Настроил dynamic inventory с помощью плагина gcp_compute
2. Изменил  секцию Provision в образе на "type": "ansible"
   Билд новых образов происходит с использованием нового провижинера
