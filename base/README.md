# Kubernetes

## Подготовка кластера

Простая установка кластера [k3s](cluster-k3s-init.md). Подойдет для начального изучения.

```bash
kubectl version

Client Version: v1.32.3+k3s1
Kustomize Version: v5.5.0
Server Version: v1.32.3+k3s1
```

## Pod

[Создание одиночного Pod](manifests/pod-single.yaml)

[Создание нескольких объектов в одном manifest-файле](manifests/pod-several.yaml)

## Service

[Создание сервиса типа ClusterIP](manifests/service-clusterip-singlepod.yaml)

[Создание сервиса типа ClusterIP для нескольких Pod](manifests/service-clusterip-multipod.yaml)

[Доступ к сервисам с помощью внутреннего DNS-имени](manifests/service-access-via-dns.yaml)

[Создание сервиса типа ExternalName](manifests/service-externalname.yaml)

[Создание сервиса типа NodePort](manifests/service-nodeport.yaml)

[Создание сервиса типа NodePort для нескольких Pod](manifests/service-nodeport-multipod.yaml)

[Создание сервиса типа NodePort для нескольких Pod с несколькими метками (label)](manifests/service-nodeport-labels.yaml)

[Создание сервиса типа LoadBalancer](manifests/service-loadbalancer.yaml)

## Namespace

[Создание пространств имен](manifests/namespace.yaml)

## ConfigMap

[Создание конфигураций для одного Pod с сервисом](manifests/configmap-single-service.yaml)

[Создание конфигураций для двух Pod с сервисами](manifests/configmap-several-services.yaml)

[Создание Pod с переменными среды без использования ConfigMap](manifests/env.yaml)

[Создание Pod с переменными среды с использованием ConfigMap](manifests/env.yaml)

[Создание Pod с секретами (логины, пароли, токены и т.п.)](manifests/secret.yaml)

## Абстракции над Pod

[Создание ReplicaSet](manifests/replicaset.yaml)

[Создание Pod с livenessProbe и readinessProbe](manifests/probes.yaml)

[Создание Deployment](manifests/deployment.yaml)

[Создание DaemonSet](manifests/daemonset.yaml)

[Создание CronJob - повторяющихся задач](manifests/cronjob.yaml)

## Ingress

[Создание Ingress - обработчика входящего трафика типа HTTP и HTTPS](manifests/ingress.yaml)

Дополнительно рекомендуется ознакомиться с **IngressController**, **GatewayAPI**.

## Volume

[Создание volume типа EmptyDir](manifests/volume-emptydir.yaml)

[Создание volume типа NFS](manifests/volume-nfs.yaml)

[Создание volume типа NFS для нескольких Pod](manifests/volume-nfs-deployment.yaml)

[Создание PersistentVolume и PersistentVolumeClaim](manifests/volume-pve-single.yaml)

[Создание PersistentVolume и PersistentVolumeClaim - использование нескольких PVC](manifests/volume-pvc-multi.yaml)

[Создание StorageClass для сервера NFS](manifests/storageclass-csi-nfs.yaml)

[Переиспользование PV после удаления PVC при использовании NFS CSI](manifests/storageclass-csi-nfs-reusage.yaml)

## RBAC

[Доступ к кластеру k3s](cluster-k3s-remote-access.md)

[Создание Role и RoleBinding в default namespace - ограниченные права](manifests/rbac-role-rolebinding-default.yaml)

[Создание Role и RoleBinding в flatnotes namespace - права администратора](manifests/rbac-role-rolebinding-default.yaml)

[Создание ServiceAccount](manifests/rbac-serviceaccount.yaml)

## GUI

[Примеры GUI для Kubernetes](gui-install.md)

[ServiceAccount для доступа к GUI](manifests/rbac-serviceaccount-gui.yaml)