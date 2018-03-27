#!/bin/bash

checkHadoopFile()
{
    if [ $# -lt 4 ] 
    then
        return -1
    fi  
    HADOOP_CLIENT=$1
    CHECK_PATH=$2
    TRY_NUM=$3
    SLEEP_TIME=$4
    while [ "$TRY_NUM" -ge 1 ] 
    do
        $HADOOP_CLIENT fs -test -e $CHECK_PATH
        if [ $? -eq 0 ] 
        then
            return 0
        fi  
        echo "try time $TRY_NUM"
        TRY_NUM=`expr $TRY_NUM - 1`
        sleep $SLEEP_TIME
    done
    return 1
}


checkHadoopSize()
{
    if [ $# -lt 4 ] 
    then
        return -1
    fi  
    HADOOP_CLIENT=$1
    CHECK_PATH=$2
    TRY_NUM=$3
    SLEEP_TIME=$4
    INIT_SIZE=$($HADOOP_CLIENT fs -du -s $CHECK_PATH | awk '{print $1}')
    while [ "$TRY_NUM" -ge 1 ]
    do
        sleep $SLEEP_TIME
        echo "try time $TRY_NUM"
        TRY_NUM=`expr $TRY_NUM - 1`
        NOW_SIZE=$($HADOOP_CLIENT fs -du -s $CHECK_PATH | awk '{print $1}')
        if [ $NOW_SIZE -eq $INIT_SIZE ]
        then
            return 0
        fi
        INIT_SIZE=$NOW_SIZE
    done
    return 1

}

wechat_alert()
{
    msg=$1
    wget -SO /dev/null "http://common.platform.adt.sogou/weixin.php?desc=liyaozong%23""%23${msg}"
}

