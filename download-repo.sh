#!/bin/bash

if cat /repolist; 
then
    for id in $(cat /repolist)
    do
        echo "------------ Downloading rpm repo for $id ------------"
        reposync --gpgcheck -l -m -n --repoid="$id" --download_path=/var/www/html/rhel_rpms
    done;
else
    reposync --gpgcheck -l -m -n --download_path=/var/www/html/rhel_rpms
fi