## Liveness

ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/

```sh
$ ssh devops@34.151.241.74 'kubectl apply -f -' < files/liveness/liveness.yaml
```

Check is is working

```sh 
$ ssh devops@34.151.241.74 'kubectl describe pod liveness-http'
$ ssh devops@34.151.241.74 'kubectl get pod liveness-http'
```