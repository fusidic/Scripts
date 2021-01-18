#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

a=`uname -a`
b="ubuntu"
c="/etc/centos-release"

if [ "$1" == "" ];then
    echo -e " ${RED}[ERROR] Missing required parameters!${NC}\n"
    echo -e " Usage:
    ./docker-proxy.sh [proxy_addr]
 Params:
    proxy_addr          Your docker proxy server address
    "
    exit 1
fi

# Add environment vars pointing Docker to use the proxy
mkdir -p /etc/systemd/system/docker.service.d
cat << EOD > /etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
Environment="HTTP_PROXY=http://${1}/"
Environment="HTTPS_PROXY=http://${1}/"
EOD

# Get the CA certificate from the proxy and make it a trusted root.
if [[ $a =~ $b ]];then
    # Ubuntu
    curl http://${1}/ca.crt > /usr/share/ca-certificates/docker_registry_proxy.crt
    echo "docker_registry_proxy.crt" >> /etc/ca-certificates.conf
    update-ca-certificates --fresh
elif [[ -f "$c" ]];then
    # CentOS
    curl http://${1}/ca.crt > /etc/pki/ca-trust/source/anchors/docker_registry_proxy.crt
    echo "docker_registry_proxy.crt" >> /etc/ca-certificates.conf
    update-ca-trust
else
    echo "System version $a"
    echo "No way"
fi

# Reload systemd
systemctl daemon-reload

# Restart dockerd
systemctl restart docker.service