## Scheduling

Indentify and label node
```sh
$ ssh devops@34.151.241.74 'kubectl get nodes'
$ ssh devops@34.151.241.74 'kubectl label nodes k8s2 disktype=ssd'
```

Run the container on labeled node
```sh
$ ssh devops@34.151.241.74  'kubectl apply -f -' < files/scheduling/node-selector.yaml
```
Remove label from node
```sh
$ ssh devops@34.151.241.74  'kubectl label nodes k8s2 disktype-'
```