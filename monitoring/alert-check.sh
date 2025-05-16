curl -L 'http://192.168.250.231:30093/api/v2/alerts' \
-H 'Content-Type: application/json' \
-H 'Accept: application/json' \
-d \
'[{
    "labels": 
    {
        "alertname": "Test Alert",
        "namespace": "monitoring",
        "severity": "Info",
        "cluster": "kubernetes"
    },
    "annotations":
    {
        "description": "This is for testing",
    }
}]'