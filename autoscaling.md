## Autoscaling

ref: https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/, https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/


```sh
$ ssh devops@34.151.241.74 'kubectl apply -f -' < files/autoscaling/php-apache.yaml
```

```sh
$ ssh devops@34.151.241.74 'kubectl apply -f -' < files/autoscaling/hpa.yaml
```

```sh
$ ssh devops@34.151.241.74 'kubectl get hpa'
```

Stressing the container

```sh
$ ssh -i ~/.ssh/vmkey devops@34.151.241.74
$ kubectl run -i --tty load-generator --image=busybox /bin/sh
# Hit enter for command prompt
$ while true; do wget -q -O- http://php-apache.default.svc.cluster.local; done
```