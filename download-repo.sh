#!/bin/bash

for id in $(cat /repolist)
do
    echo "------------ Downloading rpm repo for $id ------------"
    reposync --gpgcheck -l --repoid="$id" --download_path=/var/www/html/rhel_rpms 
done;