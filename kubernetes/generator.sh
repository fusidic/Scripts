#!/bin/bash



FILE="Compute1.txt"
NAME="eagle"
SCHEDULER_NAME="eagle-scheduler"

# 计算总行数
LINES=$(wc -l $FILE | awk '{print $1}')

# 遍历
for ((i=1; i<=$LINES; i ++))
do
    CPU_USAGE=$(sed -n ""$i"p" $FILE | awk '{print $3}')
    MEM_USAGE=$(sed -n ""$i"p" $FILE | awk '{print $4}')
    TARGET_FILE="./yaml/eagle_"$i".yaml"
    echo "cat ./base.yaml > $TARGET_FILE"

    POD_NAME="$NAME"-"$i"

    # 写入目标值
    echo "yq w -i "$TARGET_FILE" 'spec.schedulerName' $POD_NAME"
    echo "yq w -i "$TARGET_FILE" 'metadata.name' $SCHEDULER_NAME"
    echo "yq w -i "$TARGET_FILE" 'spec.containers[0].resources.limits.cpu' $CPU_USAGE"
    echo "yq w -i "$TARGET_FILE" 'spec.containers[0].resources.limits.memory' $MEM_USAGE"
    echo "yq w -i "$TARGET_FILE" 'spec.containers[0].resources.requests.cpu' $CPU_USAGE"
    echo "yq w -i "$TARGET_FILE" 'spec.containers[0].resources.requests.memory' $MEM_USAGE"
done

