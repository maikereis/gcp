## Persistent Volumes and Longhorn

ref: https://kubernetes.io/docs/concepts/services-networking/service/
ref: https://kubernetes.io/docs/concepts/storage/persistent-volumes/
ref: https://kubernetes.io/docs/concepts/workloads/controllers/deployment/

Login on rancher -> Clusters -> Default -> Apps -> Launch -> Install longhorn

```sh
$ ssh devops@34.151.241.74 'kubectl apply -f -' < files/longhorn/mariadb-longhorn-volume.yaml
```
