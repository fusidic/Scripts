#!/bin/bash

FILE="testcase.txt"
NAME="eagle"
SCHEDULER_NAME="eagle-scheduler"

# 计算总行数
LINES=$(wc -l $FILE | awk '{print $1}')

if [ ! -f "./yaml" ]
then
    mkdir yaml
fi

# 遍历
for ((i=1; i<=$LINES; i ++))
do
    CPU_USAGE=$(sed -n ""$i"p" $FILE | awk '{print $3}')"m"
    MEM_USAGE=$(sed -n ""$i"p" $FILE | awk '{print $4}')"Mi"
    TARGET_FILE="./yaml/eagle_"$i".yaml"
    cat ./base.yaml > $TARGET_FILE

    POD_NAME="$NAME"-"$i"

    # 写入目标值到 ./yaml 路径下
    yq w -i "$TARGET_FILE" 'spec.schedulerName' $SCHEDULER_NAME
    yq w -i "$TARGET_FILE" 'metadata.name' $POD_NAME
    yq w -i "$TARGET_FILE" 'spec.containers[0].resources.limits.cpu' $CPU_USAGE
    yq w -i "$TARGET_FILE" 'spec.containers[0].resources.limits.memory' $MEM_USAGE
    yq w -i "$TARGET_FILE" 'spec.containers[0].resources.requests.cpu' $CPU_USAGE
    yq w -i "$TARGET_FILE" 'spec.containers[0].resources.requests.memory' $MEM_USAGE

done

