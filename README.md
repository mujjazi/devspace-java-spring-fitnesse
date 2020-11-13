# DevSpace Demo Project For Spring Boot (Gradle)
This is a java spring boot application with a multi-stage Dockerfile and a `devspace.yaml` config file for Kubernetes based development.

Make sure to also check-out the [DevSpace Onboarding Guide](https://devspace.sh/cli/docs/guides/basics).

## Prerequisites

### 1. Install DevSpace
See [DevSpace documentation](https://devspace.sh/cli/docs/getting-started/installation) for details.

### 2. Prepare Kube-Context
If you are already using Loft, install the Loft plugin:
```bash
devspace add plugin https://github.com/loft-sh/loft-devspace-plugin
```
Then, log in to your Loft instance:
```bash
devspace login loft.company.tld
```
Then, create a space:
```bash
devspace create space my-java-app
```
If you want to try this without Loft (e.g. using a localhost test cluster) and you already have access to this cluster via `kubectl`, then run:
```bash
devspace use namespace my-java-app
```

## Development
To start developing this project, clone it and run:
```bash
devspace dev
```
You need to provide a value for `IMAGE` to define where to push the image that will be built based on the Dockerfile in this project.

You can now:
- stream the logs of your dev containers
- change any file to hot reload your java application inside the dev container
- access the application on port 8080 as well as fitnesse on port 8081
- open the DevSpace localhost UI on port 8090

### Interactive
If you do not want to 
```bash
devspace dev -p interactive
```
This will rebuild your image (only the first time or on Dockerfile changes) and use the `interactive` profile which will override the ENTRYPOINT of this image to `sleep`, so you can start the application yourself.

After the terminal opens, run this command to start this spring boot application:
```bash
./gradlew bootRun
```

### Debugging
Start interactive mode (see above):
```bash
devspace dev -p interactive
```
After the interactive terminal opens, run this command to start the application using the JVM debugger:
```bash
./gradlew bootRun --debug-jvm
```
Then, attach your IDE's debugger (e.g. hit F5 in VS code). See `.vscode/launch.json` for config options.


## Deployment
Depoy using dev config:
```bash
devspace deploy
```

### Production Profile
Deploy using production-like config:
```bash
devspace deploy -p production
```
