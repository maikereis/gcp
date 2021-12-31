#! /bin/bash
# read params

PROJECT=devops-336302
ZONE=southamerica-east1-b

while [ $# -gt 0 ]; do
  case "$1" in
    --key=*)
      key="${1#*=}"
      ;;
    --ip=*)
      ip="${1#*=}"
      ;;
    --name=*)
      name="${1#*=}"
      ;;
    --username=*)
      username="${1#*=}"
      ;;
    --script=*)
      script="${1#*=}"
      ;;
    *)
      printf "Invalid argument\n"
      exit 1
  esac
  shift
done



key_dir=$(dirname /home/maike/.ssh/vmkey.pub)
tmp_key=$(mktemp "$key_dir/temp.pub.XXXXXXX")
cat ${key} | sed -e "s/.*/${username}:&/" > $tmp_key

gcloud compute instances create ${name} \
--project=$PROJECT \
--zone=$ZONE \
--machine-type=e2-custom-2-8192 \
--network-interface=address=${ip},network-tier=PREMIUM,subnet=default \
--metadata-from-file=startup-script=${script},ssh-keys=${tmp_key} \
--maintenance-policy=MIGRATE \
--service-account=497463814319-compute@developer.gserviceaccount.com \
--scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
--create-disk=auto-delete=yes,boot=yes,device-name=instance-1,image=projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20211214,mode=rw,size=30,type=projects/devops-336302/zones/southamerica-east1-b/diskTypes/pd-balanced --no-shielded-secure-boot \
--shielded-vtpm \
--shielded-integrity-monitoring \
--reservation-affinity=any

rm -R ${tmp_key}
