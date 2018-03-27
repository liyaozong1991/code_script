# coding: utf8

import sys
import os

from pyspark.sql import SparkSession
import math
import time
import logging

# log 配置
logging.basicConfig(filename="./logs", level=logging.INFO, format="[%(levelname)s]\t%(asctime)s\tLINENO:%(lineno)d\t%(message)s", datefmt="%Y-%m-%d %H:%M:%S")

spark = SparkSession\
    .builder\
    .appName("合词相关统计_{}".format(date))\
    .config("spark.executor.memory", "30g")\
    .config("spark.executor.cores", "10")\
    .getOrCreate()

lines = spark.read.text(input_path).rdd.map().persist()
