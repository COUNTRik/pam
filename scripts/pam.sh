#!/bin/bash

# Авторизуемся для получения root прав
mkdir -p ~root/.ssh
cp ~vagrant/.ssh/auth* ~root/.ssh

# Установим необходимые пакеты
yum install -y mc vim

# Создадим пользователей и группу
useradd admin
useradd admin2
usermod -aG admin admin2
useradd neadmin

echo "admin2" | sudo passwd --stdin admin2
echo "neadmin" | sudo passwd --stdin neadmin

# Добавим параметры ограничения по времени (запретим всем пользователям, кроме группы admin логин в выходные (суббота и воскресенье)) в /etc/security/time.conf
# Здесь указан пользователь vagrant, чтобы можно было проверить на стенде vagrant, в других случаях можно заменить например на пользователя root
echo '*;*;!vagrant;!Wd0000-2400' >> /etc/security/time.conf

# Добавим строки параметров в /etc/pam.d/login
sed -i '5a\account    required     pam_time.so' /etc/pam.d/login
sed -i '5a\account [default=ignore success=1] pam_succeed_if.so  user ingroup admin' /etc/pam.d/login

# Также для наглядности и проверки на стенде vagrant добавим эти же строки параметров в /etc/pam.d/sshd
sed -i '7a\account    required     pam_time.so' /etc/pam.d/sshd
sed -i '7a\account [default=ignore success=1] pam_succeed_if.so  user ingroup admin' /etc/pam.d/sshd
# Разрешим вход через ssh по паролю
sudo bash -c "sed -i 's/^PasswordAuthentication.*$/PasswordAuthentication yes/' /etc/ssh/sshd_config && systemctl restart sshd.service"
