# xxdeenxx_infra
xxdeenxx Infra repository
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
