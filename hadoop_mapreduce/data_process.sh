#!/bin/bash

set +e
source ./log_config.sh

if [ $# -ge 1 ] 
then
    date_cur=$1
else
    date_cur=`date +%Y%m%d`
fi
date_yes=`date -d "$date_cur -1 days" "+%Y%m%d"`
job_name=""

hadoop_porsche=/opt/hadoop-client/hadoop25-porsche/hadoop/bin/hadoop
porsche_streaming=/opt/hadoop-client/hadoop25-porsche/hadoop-mapreduce/hadoop-streaming.jar

HINPUT1=""
HINPUT2=""
         
HOUTPUT=""
         
$hadoop_porsche fs -rm -r $HOUTPUT
         
set +e   
$hadoop_porsche jar $porsche_streaming \
    -D mapreduce.job.name="${job_name}_${date_cur}_LiYaozong" \
    -D mapreduce.job.reduces=100 \
    -files mapper.py,reducer.py \
    -archives hdfs://Porsche/adrp/person/liyaozong/python/python3.tar.gz#python3env \
    -cmdenv LD_LIBRARY_PATH="$LD_LIBRARY_PATH:./python3env/lib" \
    -input $HINPUT1/* \
    -input $HINPUT2/* \
    -output $HOUTPUT \
    -mapper "./python3env/bin/python3 mapper.py" \
    -reducer "./python3env/bin/python3 reducer.py"
         
if [ $? -ne 0 ]
then     
    error "$job_name failed $date_yes - $0"
    sh /search/huidu/alert/porsche_alert/porsche_alert.sh "$job_name failed $date_yes - $0"
    exit 255
else     
    $hadoop_porsche fs -touchz $HOUTPUT/_SUCCESS
fi       
info "Done: all done!"
