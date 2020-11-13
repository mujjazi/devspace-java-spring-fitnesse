################ Build & Dev ################
# Build stage will be used:
# - for building the application for production
# - as target for development (see devspace.yaml)
FROM openjdk:11 as build

# Create project directory (workdir)
WORKDIR /app

# Install dependencies using gradle
ENV GRADLE_OPTS -Dkotlin.compiler.execution.strategy="in-process"
COPY build.gradle settings.gradle gradlew ./
COPY gradle .
# This command will fail but it will download and layer-cache dependencies
RUN ./gradlew build || return 0

# Add source code files to WORKDIR
ADD . .

# Build application
RUN ./gradlew build

# Copy jar file
RUN cp build/libs/*.jar build/libs/main.jar


################ Production ################
# Creates a minimal image for production using distroless base image
# More info here: https://github.com/GoogleContainerTools/distroless
FROM gcr.io/distroless/java:11 as production

# Copy application binary from build/dev stage to the distroless container
COPY --from=build /app/build/libs/main.jar /

# Application port (optional)
EXPOSE 8080

# Container start command for production
CMD ["/main.jar"]
