#!/bin/sh

# Set maven build options
MAVEN_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1"

# Remove old .jar files
rm -f build/libs/*.jar

# Build jar file
./gradlew build

# Start application
find ./build/libs/ -name "*.jar" | xargs java -jar
