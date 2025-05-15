# Helm

Минимальная структура пакета (Chart):

```null
flatnotes/
├─ Chart.yaml    # Информация о Chart'е
├─ values.yaml   # Значения для использования в шаблонах
├─ charts/       # Зависимости
├─ templates/    # Шаблоны ресурсов (объектов) Kubernetes
│  ├─ namespace.yaml
│  ├─ configmap.yaml
│  ├─ deployment.yaml
│  ├─ service.yaml
├─ .helmignore   # Файлы, которые нужно игнорировать при сборке пакета (архива) 
```

Создать директорию для приложения:

```bash
mkdir flatnotes
cd flatnotes
```

Создать файл `Chart.yaml` с метаданными:

```bash
cat << EOF >> Chart.yaml
apiVersion: v2
name: flatnotes
description: Chart for testing

# Версия Chart'a
version: "0.1.0"

# Версия приложения (https://hub.docker.com/r/dullage/flatnotes/tags)
appVersion: "5.5.1"
EOF
```

Создать файл `values.yaml` с важными переменными:

```bash
cat << EOF >> values.yaml
replicaCount: 1

image:
  repository: dullage/flatnotes
  tag: 5.5.1

service:
  type: NodePort
  port: 80
EOF
```

Создать директорию `templates` с шаблонами:

```bash
mkdir templates
```

Создать и заполнить шаблоны.

Проверить корректность без установки:

```bash
helm install --dry-run --debug flatnotes ./flatnotes --namespace flatnotes
```

Если все ОК, установить пакет, предварительно создав `namespace`:

```bash
kubectl create namespace flatnotes
helm install flatnotes ./flatnotes --namespace flatnotes
```

Проверить список установленных пакетов:

```bash
helm list -n flatnotes
```

Удалить пакет:

```bash
helm uninstall flatnotes -n flatnotes
```

Собрать пакет из исходников, после чего появится файл (архив):

```bash
helm package flatnotes
```

Теперь можно распространить данный файл и устанавливать его:

```bash
helm install flatnotes flatnotes-0.1.2.tgz --namespace flatnotes
```
