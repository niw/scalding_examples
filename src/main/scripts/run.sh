#!/usr/bin/env bash

BASE_DIR="$(cd "$(dirname "$0")/../../.." && pwd)"

USE_HADOOP=true

case "$1" in
  -l|--local)
    USE_HADOOP=false
    shift
    ;;
esac

if [ -z "$1" ]; then
  echo "Usage: $0 [-l] job"
  echo "  -l, --local  Run Scalding in local mode without Hadoop cluster"
  exit
fi

JOB_CLASS_NAME="$1"
shift

TARGET_DIR="$BASE_DIR/target"
JAR_BASE_NAME="scalding_examples-0.1.0-SNAPSHOT"

# NOTE ${JAR_BASE_NAME}-libjars.jar doesn't contain Hadoop classes,
# because these are provided by Hadoop itself. See /src/main/assembly/libjars.xml.
APP_JAR_PATH="$TARGET_DIR/${JAR_BASE_NAME}.jar"
LIB_JAR_PATH="$TARGET_DIR/${JAR_BASE_NAME}-libjars.jar"

if $USE_HADOOP; then
  HADOOP_CLASSPATH="$APP_JAR_PATH:$LIB_JAR_PATH:$HADOO_CLASSPATH"
  export HADOOP_CLASSPATH

  exec hadoop jar "$APP_JAR_PATH" --libjars "$LIB_JAR_PATH" "$JOB_CLASS_NAME" --hdfs "$@"
else
  # -jar and -clsspath options doesn't work at same time. Use -classpath then
  # gives main class name.
  CLASSPATH="$APP_JAR_PATH:$(cat "$BASE_DIR/.classpath.txt"):$CLASSPATH"
  export CLASSPATH

  exec java com.twitter.scalding.Tool "$JOB_CLASS_NAME" --local "$@"
fi
