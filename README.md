# Jenkins LTS pre-configured with custom plugins

## About this image
* This image
    * Is based on [Jenkins LTS](https://jenkins.io/changelog-stable/)
    * Is packed with:
        * [plugins.txt](./plugins.txt)
        * docker
        * docker- compose

## How to install a new plugin
* First, install desired plugin using Jenkins UI
    * Jenkins home > Manage Jenkins > Manage Plugins > Available, search and in
* Second, update plugin list used to build jenkins custom image (if this step is skipped, next time when the build env gets build the plugin will be missing)
    * Retrieve plugin list, execute script [list_plugins.groovy](tools/list_plugins.groovy) in [jenkins](http://jenkins.example.org/script)
    * Copy above script output (minus last line, the one starting with `Result: [`), and update [plugins.txt](plugins.txt)


## How to update
### All plugins
* First, update plugins in Jenkins
    * Jenkins home > Manage Jenkins > Manage Plugins
* Second, update plugin list used to build jenkins custom image (if this step is skipped, next time when the build env gets build the plugin will be missing)
    * Retrieve plugin list, execute script [list_plugins.groovy](tools/list_plugins.groovy) in [jenkins](http://jenkins.example.org/script)
    * Copy above script output (minus last line, the one starting with `Result: [`), and update [plugins.txt](plugins.txt)

### Base image (Jenkins LTS version)
* Set base image to latest/desired Jenkins LTS [version](https://jenkins.io/changelog-stable/)

### Docker
* Set `DOCKER_VERSION` ([Dockerfile](./Dockerfile)) to latest/desired docker [version](https://github.com/docker/docker-ce/releases)

### Docker Compose
* Set `DOCKER_COMPOSE_VERSION` ([Dockerfile](./Dockerfile)) to latest/desired Docker Compose [version](https://github.com/docker/compose/releases)

## Docker Hub Automated Build
* Me on [docker hub](https://hub.docker.com/r/shoepping/jenkins-custom/)
* The build makes use of [post push hook](hooks/post_push)
* [Reference](https://docs.docker.com/docker-cloud/builds/advanced/)
