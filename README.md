# vitrez_infra
vitrez Infra repository

###### ansible-3 ##############################################

Что было сделано:

- Часть плейбуков была сконвертированы в роли со структурой от ansible-galaxy.
- Для ансибла были созданы два окружения (stage и prod) с разными инвентори.
- Переменные для групп хостов были перенесены в файлы групп group_vars каждого из окружений.
- Реорганизовано хранение плейбуков, ролей и переменных по каталогам.
- Добавлена роль jdauphant.nginx из ansible-galaxy и настроено обратное проксирование для нашего приложения с помощью nginx через порт 80.
- Добавлен плейбук создания пользователей на инстансах.
- Использовали ansible vault для шифрования файлов-переменных с учетными данными пользователей.
- В окружениях используются динамические инвентори на базе модуля gce_compute.


###### ansible-2 ##############################################

Что было сделано:

- Написан и проверен плейбук для создания инфраструктуры по принципу: один плейбук - один сценарий (со множеством задач). В нем использовали шаблоны и хэндлеры. Для раздельного применения задач плейбука (группы хостов - группы задач) необходимо использовать ключи запуска --limit и --tags.
- Написан и проверен плейбук для создания инфраструктуры по принципу: один плейбук - много сценариев (несколько директив "hosts"). Для раздельного применения сценариев плейбука теперь в строке запуска достаточно указать теги сценариев через --tags.
- Рассмотрели вариант разбиения задач и хостов по нескольким плейбукам (самый оптимальный). Проверена работа общего плейбука, содержащего только импорт раздельных плейбуков.
- Изменен скрипт для создания динамического инвентори. Теперь json на выходе сортирует по именам (а не только по ip), разбивает хосты пo группам, добавляет кастомную переменную (privateIP), используемую в темплейте db_config.j2.
- Добавлены 2 плейбука для Packer для установки базовых пакетов MongoDB и Ruby перед сборкой образа. Теперь в конфигах Packer (stage) вместо shell скриптов используется провижнер ansible и ссылки на плейбуки.

ВНИМАНИЕ:
- для правильного применения с Packer опции плейбуков "become=yes", необходимо запускать сам packer не от root, а с правами обычного пользователя (https://packer.io/docs/provisioners/ansible.html#become-yes)
- в методичке по ДЗ (по ссылке ниже) ошибка в плейбуке packer_app.yml, там необходимо добавить опцию "update_cache: yes" в модуле apt (аналог "apt update"), т.к. в дефолтовом образе Ubuntu_16.04LTS нет пакета "ruby-full".
 (https://gist.github.com/Nklya/bb2ca080692f75ef1cb2dd24a9926fa8#file-packer_app-yml)


###### ansible-1 ##############################################

Что было сделано:

- Установлен и настроен ansible с сопутствующими библиотеками, программами и утилитами
- Поднято терраформом stage-окружение и проверена работа ansible с ним
- Опробована работа с использованием инвентори-файлов: inventory (ini-формат), inventory.yml (yaml-формат), конфигом ansible.cfg и с группами хостов
- Проверено и проведено сравнение выполнения команд на хостах с использованием различных модулей - shell, command, systemd, service, git
- Создан плейбук "clone" и проверена его идемпотентность
- Освоена и проверена работа ansible с динамическим инвентори в JSON-формате с использованием плагина gcp_compute
- Для использования плагина gcp_compute был установлен python-модуль google-auth и создана сервисная учетка в GCP с аутентификацией по ключу в виде json-файла

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
