# vitrez_infra
vitrez Infra repository

###### terraform-2 ############################################

Что было сделано:

- создана конфигурация для правил firewall, а также обновлена через функцию inmport
- на основании базового образа созданы Packer два других образа: один с БД Mongo, другое с Ruby
- конфигурация terraform также разделена на слои app, db и vpc и проверена в работе
- конфигурации terraform преобразованы в модули app, db и vpc, параметризованы и проверены в работе
- обновлено и проверено правило брандмауэра для ограничения соединений только с адреса нашего провайдера
- созданы две среды: stage и prod, с одинаковым использованием модулей
- добавлен модуль внешнего хранилища для создания бакетов
- создан bucket для удаленного хранения состояния Terraform
- в обоих средах (stage и prod) видется общий state Terraform в удаленном хранилище
- при попытке одновременно запустить применение конфигураций stage и prod срабатывает блокировка
- после проверки всех результатов все ресурсы удалены "terraform destroy"

###### terraform-1 ############################################

Что было сделано:

- Создана новая ветка terraform-1;
- Создан main.tf - главный конфигурационный файл, содержащий декларативное описание нашей инфраструктуры;
- Создан outputs.tf - файл, содержащий описание переменных, выгружаемые Terraform после выполнения задания;
- Создан variables.tf - файл, содержащий описание входных переменных, используемых в главном конфигурационном файле;
- Создан terraform.tfvars - файл, содержашщий значения переменных из variables.tf;
- Выполнено самостоятельное задание с объявлением переменных и создан terraform.tfvars.example;
- Выполнено задание с *, где необходимо добавить ssh ключи в метаданные проекта для пользователей appuser1, appuser2, appuser2;
- Добавленный вручную через web-интерфейс ключ appuser_web, после выполнения terraform apply - удаляется.

###### packer-base ############################################

Что было сделано:

- установлен ADC для GCP на локальной машине;
- подготовлен шаблон Packer и скрипты, создающие pre-backed образ 'reddit-base' на базе образа Ubuntu и установленных Ruby и MongoDB;
- предыдущий шаблон Packer был изменен, используя параметризацию и пользовательские переменные;
- подготовлен шаблон Packer и скрипты, создающие pre-backed образ 'reddit-full' на базе образа 'reddit-base' с развернутым приложением Puma, готовым к работе сразу после создания VM из образа.

Как создать инстанс GCP, используя образ 'reddit-full':

sudo gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family reddit-full --machine-type=g1-small --tags puma-server --restart-on-failure


###### cloud-testapp ##########################################

testapp_IP = 35.228.199.13
testapp_port = 9292

Как создать инстансы, используя startup.sh:
gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --metadata startup-script=startup.sh

Как создать правило firewall используя gcloud:
gcloud compute firewall-rules create default-puma-server --allow tcp:9292 --target-tags=puma-server


###### cloud-bastion ############################################

bastion_IP = 35.228.219.101
someinternalhost_IP = 10.166.0.3

# Самостоятельное задание.
#Подключение к someinternalhost одной командой:
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
