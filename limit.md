## Limit

```sh 
$ ssh devops@34.151.241.74 'kubectl create namespace constraints-cpu-example'
$ ssh devops@34.151.241.74 'kubectl apply -f -' < files/limit/cpu-constraints.yaml
$ ssh devops@34.151.241.74 'kubectl get limitrange cpu-min-max-demo-lr --output=yaml --namespace=constraints-cpu-example'
```

```sh
$ ssh devops@34.151.241.74 'kubectl apply -f -' < files/limit/cpu-constraints-pod.yaml
$ ssh devops@34.151.241.74 'kubectl get limitrange cpu-min-max-demo-lr --output=yaml --namespace=constraints-cpu-example'
$ ssh devops@34.151.241.74 'kubectl get pod constraints-cpu-demo --output=yaml --namespace=constraints-cpu-example'
```

```sh
$ ssh devops@34.151.241.74 'kubectl delete pod constraints-cpu-demo --namespace=constraints-cpu-example'
```

```sh
$ ssh devops@34.151.241.74 'kubectl apply -f -' < files/limit/cpu-constraints-pod2.yaml
```