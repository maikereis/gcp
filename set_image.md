## Set Image

ref: https://kubernetes.io/docs/tutorials/kubernetes-basics/update/update-intro/

```sh
$ ssh devops@34.151.241.74 'kubectl apply -f -' < files/set_image/set_image.yaml
```

Set image
```sh
$ ssh devops@34.151.241.74 'kubectl set image deployments/my-nginx nginx=nginx:1.9.1'
```
Verify images
```sh
$ ssh devops@34.151.241.74 'kubectl get pods -l app=nginx -L deployment'
```