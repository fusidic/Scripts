#!/bin/bash

if [[ $(uname -s) != "Darwin" ]]; then
    echo "macOS only"
    exit 1
fi

echo "ClashX: importing user configuration"
path1="/Users/fusidic/.config/clash/"
ls $path1

read -t 15 -p "Input destinate config filename: " filename
# default value of filename
filename=${filename:-fq.mk.yaml}

echo "import user config to ${filename}"
cat ${path1}user.yaml >> ${path1}${filename}

echo "export Sys-env"
export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7891
export GO111MODULE=auto
