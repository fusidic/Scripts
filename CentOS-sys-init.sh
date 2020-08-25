#!/bin/bash
# Author:	Fusidic
# Date:		2020-08-22

# system-level
add_user()
{
    echo "TODO"
}

close_selinux()
{
    echo "start to disable selinux ..."
    setenforce 0
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
    echo "selinux diabled !!!"
}

change_registry_tsinghua()
{
    echo "mirror.tuna.tsinghua.edu.cn"
    echo "backing up ..."
    sudo cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
    wget https://raw.githubusercontent.com/fusidic/Scripts/master/config/CentOS-Base.repo.tsinghua -O /etc/yum.repos.d/CentOS-Base.repo
    sudo yum makecache
}

change_registry_aliyun()
{
    echo "mirror.aliyun.com"
    echo "backing up ..."
    sudo cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
    wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
    sudo yum makecache
}

print_system_info()
{
    echo "**********************************"
    echo "Powered by fusidic"
    echo "Email: arithbar@gmail.com"
    echo "Hostname:" `hostname`
    # virtualization
    cat /proc/cpuinfo |grep vmx >> /dev/null
    if [ $? == 0 ]
    then
        echo "Supporting virtualization"
    else
        echo "Virtualization is not supported"
    fi
    echo "Cpu model:" `cat /proc/cpuinfo |grep "model name" | awk '{ print $4" "$5""$6" "$7 ; exit }'`
    echo "Memory:" `free -m |grep Mem | awk '{ print $2 }'` "M"
    echo "Swap: " `free -m |grep Swap | awk '{ print $2 }'` "M"
    echo "Kernel version: " `cat /etc/redhat-release`
    echo "**********************************"
}



help()
{
    echo "1) install_software	   6) close_selinux	    11) add_user"
    echo "2) install_python	   7) install_docker	    12) exit"
    echo "3) set_static_ip	   8) change_docker_mirror  13) help:"
    echo "4) close_firewalld	   9) change_swap"
    echo "5) set_hostname		  10) install_ohmyzsh"
}

# basic softwares

install_basic_softwares()
{
    echo "start to install basic softwares ..."
    sudo yum install -y ca-certificates ssl-cert wget curl vim* net-tools git
}


install_docker()
{
    sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install docker-ce docker-ce-cli containerd.io
    sudo systemctl start docker
}

disable_swap()
{
    echo "diable swap..."
    echo "swap status for now :"
    free -m
    echo "swap off"
    swapoff -a
    echo "swap status for now :"
    free -m
    sed -i '/swap/d' /etc/fstab
    echo "swap has been disabled & reboot required !!"
}

set_static_ip()
{
    echo "check it at /etc/sysconfig/network-scripts/"
    echo "TODO"
}

install_golang()
{
    wget https://storage.googleapis.com/golang/getgo/installer_linux
    chmod +x ./installer_linux
    ./installer_linux
    source ~/.bash_profile
    source ~/.zshrc
}

install_and_config_zsh()
{
    yum install zsh
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    wget https://github.com/fusidic/Scripts/blob/master/config/zshrc -O ~/.zshrc
    source ~/.zshrc
}

install_golang_centos7_only()
{
    echo "start to install golang (CentOS)"
    sudo rpm --import https://mirror.go-repo.io/centos/RPM-GPG-KEY-GO-REPO
    curl -s https://mirror.go-repo.io/centos/go-repo.repo | sudo tee /etc/yum.repos.d/go-repo.repo
    sudo yum install golang
    echo "finished"
    which go
}

install_golang_ubuntu()
{
    sudo add-apt-repository ppa:longsleep/golang-backports 
    sudo apt-get update
    sudo apt-get install golang-go
}

main()
{
    print_system_info
    centos_func="add_user set_static_ip close_selinux disable_swap change_registry_tsinghua change_registry_aliyun install_basic_softwares install_docker install_golang install_and_config_zsh help exit"
    select centos_func in $centos_func:
    do
        case $REPLY in
        1) add_user
        ;;
        2) set_static_ip
        ;;
        3) close_selinux
        ;;
        4) disable_swap
        ;;
        5) change_registry_tsinghua
        ;;
        6) change_registry_aliyun
        ;;
        7) install_basic_softwares
        ;;
        8) install_docker
        ;;
        9) install_golang
        ;;
        10) install_and_config_zsh 
        ;;
        11) help
        ;;
        12) exit
        ;;
        *) echo "select anything u want"
        ;;
        esac
    done
}

main