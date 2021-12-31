## Traefik as Ingress Controller

ref: https://doc.traefik.io/traefik/v1.7/user-guide/kubernetes/


```sh
$ ssh devops@34.151.241.74 'kubectl apply -f -' < files/traefik/trfk-rbac.yaml
$ ssh devops@34.151.241.74 'kubectl apply -f -' < files/traefik/trfk-ds.yaml
```
checking 
```sh
$ ssh devops@34.151.241.74 'kubectl --namespace=kube-system get pods'
```

install ui
```sh
$ ssh devops@34.151.241.74 'kubectl apply -f -' < files/ui.yml
```
uninstall

```sh
$ ssh devops@34.151.241.74 'kubectl delete -f -' < files/traefik/trfk-rbac.yaml
$ ssh devops@34.151.241.74 'kubectl delete -f -' < files/traefik/trfk-ds.yaml
```