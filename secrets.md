## Secrets

ref: https://kubernetes.io/docs/concepts/configuration/secret/

Create a fake hash username and password

```sh
echo -n devops | base64
echo -n devopspass | base64
```
Write the values on secrets.yaml

```sh
$ ssh devops@34.151.241.74 'kubectl apply -f -' < files/secrets/secrets.yaml
```


