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


docker build \
  --build-arg build_date="${BUILD_DATE}" \
  --build-arg scala_version="${SCALA_VERSION}" \
  -f docker/base/Dockerfile \
  -t base:latest .

docker build \
  --build-arg build_date="${BUILD_DATE}" \
  --build-arg spark_version="${SPARK_VERSION}" \
  --build-arg hadoop_version="${HADOOP_VERSION}" \
  -f docker/spark-base/Dockerfile \
  -t spark-base:${SPARK_VERSION} .

docker build \
  --build-arg build_date="${BUILD_DATE}" \
  --build-arg spark_version="${SPARK_VERSION}" \
  -f docker/spark-master/Dockerfile \
  -t spark-master:${SPARK_VERSION} .

docker build \
  --build-arg build_date="${BUILD_DATE}" \
  --build-arg spark_version="${SPARK_VERSION}" \
  -f docker/spark-worker/Dockerfile \
  -t spark-worker:${SPARK_VERSION} .

docker build \
  --build-arg build_date="${BUILD_DATE}" \
  --build-arg scala_version="${SCALA_VERSION}" \
  --build-arg spark_version="${SPARK_VERSION}" \
  --build-arg jupyterlab_version="${JUPYTERLAB_VERSION}" \
  --build-arg scala_kernel_version="${SCALA_KERNEL_VERSION}" \
  -f docker/jupyterlab/Dockerfile \
  -t jupyterlab:${JUPYTERLAB_VERSION}-spark-${SPARK_VERSION} .

docker-compose up -d