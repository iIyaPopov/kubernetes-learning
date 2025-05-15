# Argo CD

## Установка Argo CD

[Документация](https://argo-cd.readthedocs.io/en/stable/getting_started/) по установке ArgoCD в Kubernetes.

```bash
kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:443
```

Открыть в браузере: `192.168.x.x:8080`.

Логин - `admin`.

Пароль - `kubectl get secret argocd-initial-admin-secret -n argocd -o yaml`

```yaml
...
data:
  password: TzlJS2trTnZvQzBsMVhpOA==
...
```

Декодировать строку из формата Base64:

```bash
echo "TzlJS2trTnZvQzBsMVhpOA==" | base64 --decode
O9IKkkNvoC0l1Xi8
```

Или все то же самое, только одной командой:

```bash
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath='{.data.password}' | base64 --decode
```

## Установка Git-репозитория

[Документация](https://docs.gitea.com/installation/install-on-kubernetes) по установке Gitea в Kubernetes.

```bash
helm repo add gitea-charts https://dl.gitea.com/charts/

kubectl create namespace gitea

helm install gitea gitea-charts/gitea --namespace gitea
```

Узнать метки установленного сервиса ClusterIP:

```bash
kubectl describe svc gitea-http --namespace gitea
```

Для доступа извне кластера нужно создать сервис NodePort или [LoadBalancer](../manifests/argocd-examples/argocd-gitia-service-loadbalancer.yaml).

После установки нужно зарегистрировать пользователя. Пользователь `user` зарезервирован.

Первый зарегистрированный (например, `admin`) будет администратором?

Далее необходимо самостоятельно разобраться в интерфейсе Gitea.

## Тестирование Argo CD

### Использование manifest-файлов

1. Создать репозиторий.
1. В репозитории создать дирекоторию для приложения, например, `nginx`.
1. В директории `nginx` создать файл [`manifest.yaml`](../manifests/argocd-examples/argocd-nginx.yaml).
1. Через веб-интефрейс Argo CD создать приложение.

   **Важно:** namespace приложения - это namspace manifest-файла приложения Argo CD, а не разворачиваемого приложения.

   Указать в приложении Argo CD ранее созданную директорию `nginx`.

1. Проверить доступность.

### Использование Helm Charts

1. Создать репозиторий или использовать уже созданный.
1. Создать директорию `HelmCharts`. В этой директории создать директорию для приложения, например, `flatnotes`.
1. Загрузить файлы готового Helm Chart в созданную директорию.
1. Указать в приложении Argo CD директорию `flatnotes`.
1. Проверить доступность.

## Использование manifest-файлов для приложений в Argo CD

Управлять приложениями Argo CD может быть неудобно через веб-интерфейс, поэтому есть возможность создать [manifest-файл](../manifests/argocd-examples/argocd-app.yaml) для приложения, как для объектов Kubernetes.

Применить:

```bash
kubectl apply -f app1-argocd-app.yaml
```

Удалить:

```bash
kubectl delete -f app1-argocd-app.yaml
```

## Использование приложения для управления приложениями

Смысл в том, чтобы создать одно приложение, которое следит за одной директорией, в которой размещаются файлы `kind: Application`, на основе которых уже разворачиваются приложения.

Получается "двойная" автоматизация.

Например, создать директорию `apps`, в которую поместить файл `app1.yaml`, в котором разместить манифест из примера выше. Далее создать один раз через веб-интерфейс, например, приложение Argo CD, далее оно будет автоматически создавать остальные приложения.

Вместо создания "корневого" приложения через веб-интерфейс можно [создать manifest](../manifests/argocd-examples/argocd-root-of-app.yaml) и применить его через `kubectl`.
