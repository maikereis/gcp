## Cronjob

ref: https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/

```sh
$ ssh devops@34.151.241.74 'kubectl apply -f -' < files/cronjob/cronjob.yaml
```
Check if is working

```sh
$ ssh devops@34.151.241.74 'kubectl get cronjob hello'
```
