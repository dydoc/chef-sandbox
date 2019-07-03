#!/bin/bash
# ------------------------------------------------------------------
# [Author] Title
#          Description
# ------------------------------------------------------------------

set -e
set +x

apt-get install curl
curl https://packages.chef.io/files/stable/chefdk/4.0.60/ubuntu/16.04/chefdk_4.0.60-1_amd64.deb -o /tmp/chefdk_4.0.60-1_amd64.deb
dpkg -i /tmp/chefdk_4.0.60-1_amd64.deb
echo "$USER"
