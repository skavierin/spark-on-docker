#!/bin/bash
#
# -- Build Apache Spark Standalone Cluster Docker Images

# ----------------------------------------------------------------------------------------------------------------------
# -- Variables ---------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------

BUILD_DATE="$(date -u +'%Y-%m-%d')"

SPARK_VERSION="3.2.0"
JUPYTERLAB_VERSION="3.2.5"

HADOOP_VERSION="3.2"
SCALA_VERSION="2.12.10"
SCALA_KERNEL_VERSION="0.10.9"

docker-compose down

docker volume rm "hadoop-distributed-file-system"

docker rmi base:latest
docker rmi spark-base:${SPARK_VERSION}
docker rmi spark-master:${SPARK_VERSION}
docker rmi spark-worker:${SPARK_VERSION}
docker rmi jupyterlab:${JUPYTERLAB_VERSION}-spark-${SPARK_VERSION}

