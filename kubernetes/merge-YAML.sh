#!/bin/bash

path='/Volumes/nuaa/yaml'
files=$(ls $path)
echo $files

# touch testcase.yaml

# for filename in $files
# do
#     cat "${path}/${filename}" >> testcase.yaml
#     echo "---" >> testcase.yaml
# done

# 以第一列的数值为准进行去重
sort -k 1,1 -u Memory_bias.txt > Memory_slim.txt
    
# 分别求第三列与第四列的累加和
cat testcase.txt| awk 'BEGIN{memSum=0;cpuSum=0}{memSum+=$4}{cpuSum+=$3}END{print cpuSum"\t"memSum"\t"cpuSum/memSum}'
