# vitrez_infra
vitrez Infra repository

bastion_IP = 35.228.219.101, someinternalhost_IP = 10.166.0.3

# Самостоятельное задание.
# Подключение к someinternalhost одной командой:
ssh -i ~/.ssh/appuser -A appuser@35.228.219.101 -t ssh 10.166.0.3

# или после использования ssh-add так:
ssh -i -A appuser@35.228.219.101 -t ssh 10.166.0.3

# Дополнительное задание.
# Необходимо создать такой конфиг ~/.ssh/config:
Host    someinternalhost
        Hostname 10.166.0.3
        User appuser
        ForwardAgent yes
        ProxyCommand ssh appuser@35.228.219.101 -W %h:%p
# Теперь возможно подключаться к хосту так:
ssh someinternalhost
