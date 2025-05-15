# Доступ к кластеру k3s

## Попытка доступа к кластеру не под рутом

`su - user`

`kubectl get nodes`

*Результат:*
*Unable to read /etc/rancher/k3s/k3s.yaml*

`cat /etc/rancher/k3s/k3s.yaml`

*Результат:*
*cat: /etc/rancher/k3s/k3s.yaml: Permission denied*

`ls -la /etc/rancher/k3s/`

*Результат:*
*-rw------- 1 root root 2961 Apr 27 14:40 k3s.yaml*

❌ **Доступа нет**

## Доступ к кластеру не под рутом с manager node

```bash
su - root
mkdir /home/user/.kube/
cp /etc/rancher/k3s/k3s.yaml /home/user/.kube/config
chown -R user:user /home/user/

su - user
export KUBECONFIG=/home/user/.kube/config
kubectl get nodes
```

✅ **Доступ должен появиться**

### Альтернативный способ (не рекомендуется)

```bash
su - root
chmod 777 /etc/rancher/k3s/k3s.yaml

su - user
kubectl get nodes
```

✅ **Доступ должен появиться**

## Доступ к кластеру с произвольного устройства

Скопировать файл аналогично примеру выше на устройство управления, например, *k3s-agent-1.netlab*. Сделать это можно с помощью утиилиты `scp`.

Заменить адрес кластера на нужный. Если будет ошибка о некорректном адресе, то нужно внимательно изучить ошибку.

```bash
kubectl get nodes
```

✅ **Доступ должен появиться**

## Создание сертификата для пользователя

Нужно это, чтобы пользователи не работали от имени root.

```bash
openssl genrsa -out flatnotes-admin.key 2048

openssl req -new -key flatnotes-admin.key -out flatnotes-admin.csr -subj "/CN=flatnotes-admin/O=netlab"

K3S_CA_KEY="/var/lib/rancher/k3s/server/tls/client-ca.key"
K3S_CA_CRT="/var/lib/rancher/k3s/server/tls/client-ca.crt"

openssl x509 -req -in flatnotes-admin.csr -CA $K3S_CA_CRT -CAkey $K3S_CA_KEY -CAcreateserial -out flatnotes-admin.crt -days 7
```

```bash
kubectl config set-credentials flatnotes-admin --client-certificate=flatnotes-admin.crt --client-key=flatnotes-admin.key

kubectl config view
```

*Результат:*

```yaml
 ...
 users:
 ...
 - name: flatnotes-admin
   user:
     client-certificate: /home/user/k3s/flatnotes-admin.crt
     client-key: /home/user/k3s/flatnotes-admin.key
```

```bash
kubectl config set-context flatnotes --cluster=default --namespace=default --user=flatnotes-admin

kubectl config view
```

### Проверка

```bash
kubectl config use-context flatnotes
kubectl config current-context
```

```bash
kubectl create namespace ns-test
```

*Результат:*
*Error from server (Forbidden): namespaces is forbidden: User "flatnotes-admin" cannot create resource "namespaces" in API group "" at the cluster scope*

```bash
kubectl get pods
```

*Результат:*
*Error from server (Forbidden): pods is forbidden: User "flatnotes-admin" cannot list resource "pods" in API group "" in the namespace "default"*

## Создание роли и привязка к пользователю

```bash
kubectl config use-context default
kubectl apply -f <filename>
```

```bash
kubectl config use-context flatnotes
kubectl config flatnotes --namespace flatnotes
kubectl apply -f <filename>
kubectl get pods -n default
kubectl get pods -n flatnotes
```

Далее в рамках нового контекста можно создавать объекты.

✅ **Доступ должен появиться**
