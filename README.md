# vitrez_infra
vitrez Infra repository

###### cloud-testapp ##########################################

testapp_IP = 35.228.199.13
testapp_port = 9292

# Как создать инстансы, используя startup.sh:
gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --metadata startup-script=startup.sh

# Как создать правило firewall используя gcloud:
gcloud compute firewall-rules create default-puma-server --allow tcp:9292 --target-tags=puma-server


###### cloud-bastion ############################################

bastion_IP = 35.228.219.101
someinternalhost_IP = 10.166.0.3

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
