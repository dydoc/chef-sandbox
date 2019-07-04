#!/bin/bash
# ------------------------------------------------------------------
# [Author] Title
#          Description
# ------------------------------------------------------------------

set -e
set +x

apt-get install curl
curl https://packages.chef.io/repos/apt/stable/ubuntu/18.04/chefdk_3.9.0-1_amd64.deb  -o /tmp/chefdk_3.9.0-1_amd64.deb
dpkg -i /tmp/chefdk_3.9.0-1_amd64.deb
echo "$USER"
