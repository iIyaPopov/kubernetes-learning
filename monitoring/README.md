# Мониторинг узлов кластера

Стек:

- Node Exporter
- Prometheus
- Grafana

1. Создать [namespace](manifests/namespace.yaml)
1. Создать [DaemonSet](manifests/node-exporter.yaml) для Node Exporter.
1. Создать [Deployment](manifests/prometheus.yaml) для Prometheus. Допольнительно нужно создать кластерную роль (или обычную роль в рамках созданного namespace).
1. Создать Deployment для Grafana.
