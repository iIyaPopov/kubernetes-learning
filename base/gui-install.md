# Kubernetes GUI

## Kubernetes Dashboard

### Установка с помощью Helm

[Документация](https://helm.sh/docs/intro/install/)

```bash
su - root
cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard
kubectl get services -n kubernetes-dashboard
```

```bash
kubectl port-forward --address 0.0.0.0 service/kubernetes-dashboard-kong-proxy 8443:443 -n kubernetes-dashboard
```

Доступ только изнутри кластера.

### Доступ извне

Данный способ подходит только для отладки. На постоянной основе лучше создать сервис типа NodePort.

Подключится по адресу `https://<IP>:8443`, где `IP` - адрес ноды, где выполнялась команда с `port-forward`.

### Токен

Создать ServiceAccount, выдать права на namespace.

```bash
kubectl create token admin -n default
kubectl -n kubernetes-dashboard create token admin
```

На экране появится токен (длинная строка). Ее скопировать и вставить в поле в браузере.

Откроется панель управления.

❗ **В поле namespace нужно вручную ввести название namespace.**

### Config

Для доступа можно просто скопировать файл конфигурации в поле.

## k9s

```bash
curl -sS https://webinstall.dev/k9s | bash

k9s --kubeconfig /etc/rancher/k3s/k3s.yaml
```
