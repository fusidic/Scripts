#!/bin/bash

# 逐行读取变量

FILEPATH="./shitty-volume.log"

# also, we could use "for line in 'cat t.txt'; do echo $line done" instead.
cat $FILEPATH | while read line
do
    # openstack volume set --state available $line
    # cinder reset-state --state available --attach-status detached $line
    # openstack volume delete --force $line
    cinder delete $line
done

openstack volume list
