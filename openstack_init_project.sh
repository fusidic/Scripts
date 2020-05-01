#!/bin/bash
# Author:       TripleZ<me@triplez.cn>
# Date:         2019-04-17

# HOW TO USE:
# ./init-project.sh project_name security_group_name floating_ip_count

RED='\033[0;31m'
NC='\033[0m' # No Color


echo -e "\n Create a top router(with gateway), initialize the named security group and
 allocate the specific number of floating IPs.\n"

if [ "$1" == "" ] || [ "$2" == "" ] || [ "$3" == "" ]
then
        echo -e " ${RED}[ERROR] Missing required parameters!${NC}\n"
        echo -e " Usage:
        ./init-project.sh [project_name] [security_group_name] [floating_ip_count]

 Params:
        project_name            Your project name
        security_group_name     Your security group name (Default: \"default\")
        floating_ip_count       The number of floating IPs will be allocated to the project
        "
else

        export OS_PROJECT_DOMAIN_NAME=default
        export OS_USER_DOMAIN_NAME=default
        export OS_TENANT_NAME=admin
        export OS_USERNAME=admin
        export OS_PASSWORD=openstackdc
        export OS_AUTH_URL=http://10.0.0.254:35357/v3
        export OS_INTERFACE=internal
        export OS_IDENTITY_API_VERSION=3
        # Create a new router
        openstack router create --project $1 $1-router

        # Set the router gateway
        openstack router set --enable --external-gateway external --fixed-ip subnet=external-share $1-router

        ADMIN_SEC_GROUP=$(openstack security group list --project $1 | awk '/ default / {print $2}')
        openstack security group rule create --remote-ip 0.0.0.0/0 --protocol icmp --ingress --project $1 ${ADMIN_SEC_GROUP}
        openstack security group rule create --remote-ip 0.0.0.0/0 --protocol tcp --ingress --project $1 ${ADMIN_SEC_GROUP}
        openstack security group rule create --remote-ip 0.0.0.0/0 --protocol udp --ingress --project $1 ${ADMIN_SEC_GROUP}

        for i in $(seq 1 $3); \
                do openstack floating ip create --subnet external-share --project $1 external; \
        done
fi

