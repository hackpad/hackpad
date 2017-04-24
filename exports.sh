#!/bin/bash

export SCALA_HOME="/usr/share/scala"
export SCALA="/usr/bin/scala"
export SCALA_LIBRARY_JAR="/usr/share/scala/lib/scala-library.jar"

export JAVA_HOME="/usr/share/java"
export JAVA="/usr/bin/java"

export JAVA_OPTS="-Xmx1024M -Xms1024M -Xbootclasspath/p:../infrastructure/lib/rhino-js-1.7r3.jar:$SCALA_LIBRARY_JAR"
export MYSQL_CONNECTOR_JAR="$PWD/lib/mysql-connector-java-5.1.34-bin.jar"
export PATH="$JAVA_HOME/bin:$SCALA_HOME/bin:$PATH"