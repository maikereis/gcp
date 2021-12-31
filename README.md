# Steps to manually setup a cluster on Google Cloud Platform using rancher


# 1. Get new SSH keys!

You will need SSH keys to connect to VM on GCP. This key will be passed to `createvm` script which will include your public key during the machine creation.

```sh
ssh-keygen -t rsa -f <key-path> -C <your-username>
```
E.g: 
```sh
ssh-keygen -t rsa -f ~/.ssh/vmkey -C devops
```
<br>
# 2. Configure the startup script

You can configure a script to perform tasks during the startup, such as updates or programs installation.

Inside the folder [scripts](scripts) you can reach the [startup_script.sh](scripts/startup.sh). Wich is configured to install git and docker on VM.

scripts/startup.sh:

```sh
#! /bin/bash
sudo su
apt-get install git -y
curl https://releases.rancher.com/install-docker/20.10.sh | sh
usermod -aG docker ubuntu

```
<br>

# 3. Create VM instances

The [createvm](scripts/createvm.sh) is a wrapper for the gcloud command. This will automatically update a default VM model with new IP and name and will pass the startup script and the SSH key.

Inside the script, you must replace PROJECT and ZONE variables with yours.

```sh
$ cd scripts
$ ./createvm.sh --ip=34.95.134.36 --name=k8s0 --key=/home/maike/.ssh/vmkey.pub --script=./startup.sh --username=devops
$ ./createvm.sh --ip=35.198.57.145 --name=k8s1 --key=/home/maike/.ssh/vmkey.pub --script=./startup.sh --username=devops
$ ./createvm.sh --ip=35.247.212.89 --name=k8s2 --key=/home/maike/.ssh/vmkey.pub --script=./startup.sh --username=devops
$ ./createvm.sh --ip=34.151.241.74 --name=rancher-server --key=/home/maike/.ssh/vmkey.pub --script=./startup.sh --username=devops
```
# 3.1 Transfer ssh key
```sh
$ ssh -i ~/.ssh/vmkey devops@34.95.134.36
$ exit
$ ssh -i ~/.ssh/vmkey devops@35.198.57.145
$ exit
$ ssh -i ~/.ssh/vmkey devops@35.247.212.89
$ exit
$ ssh -i ~/.ssh/vmkey devops@34.151.241.74
$ exit
```

<br>

# 4. Install rancher

Login on rancher VM:
```sh
$ ssh devops@34.151.241.74 'sudo mkdir /opt/rancher'
```
Install the rancher container
```sh
$ ssh devops@34.151.241.74 'sudo docker run -d -v /opt/rancher:/var/lib/rancher --restart=unless-stopped -p 80:80 -p 443:443 --privileged rancher/rancher:v2.4.3'
```
Access the GCP console, under VM instances edit the rancher-server VM and mark the option "Accept HTTP"

Wait until the rancher is up to work and access the rancher-server IP(34.151.241.74) in your browser.

If the rancher version is v2.6.2+:

Follow the instructions and login on rancher.

```sh
docker logs `docker ps --format {{.ID}}` 2>&1 | grep "Bootstrap Password:"
```

<br>

# 5. Install kubectl on rancher

Run the script [install_kubectl](scripts/install_kubectl.sh) on the rancher-server

```sh
$ cd scripts
$ ssh devops@34.151.241.74 'bash -s' < install_kubectl.sh
```
Under rancher go to Cluster -> Click on "Kubeconfig File" -> Copy the content to clipboard

Paste the content on the file "~/.kube/config" under the rancher-server machine
```sh
$ sudo nano ~/.kube/config
```
Test if is working

```sh
$ kubectl get nodes
```
<br>

# 6. Create cluster

Login on rancher go to Cluster Managment -> Create (button)-> Custom -> Next -> Mark etcd and Control Plane (checkbox)

Copy the generated code and paste in a file called node_command.sh and execute for each node IP:

```sh
$ cd scripts
$ ssh devops@34.95.134.36 'bash -s' < node_command.sh   #-k8s0
$ ssh devops@35.198.57.145 'bash -s' < node_command.sh   #-k8s1
s ssh devops@35.247.212.89 'bash -s' < node_command.sh   #-k8s2
```

Wait until the cluster is up to work. You can see the cluster status on rancher web page -> Cluster Management

<br>

# 7. Install applications

[traefik - ingress controller](traefik.md)
[persistent volumes and longhorn](longhorn.md) 