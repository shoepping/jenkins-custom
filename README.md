# Jenkins LTS pre-configured with plugins

## About this image
* This image 
    * aims to follow latest [Jenkins LTS ](https://jenkins.io/changelog-stable/)
    * has specific plugins installed
    * has docker installed
    * has docker compose installed

## How to update plugins
* Execute script [update_plugins.groovy](tools/update_plugins.groovy) in [jenkins](http://jenkins.example.org/script)
* Execute script [list_plugins.groovy](tools/list_plugins.groovy) in [jenkins](http://jenkins.example.org/script)
* Copy above script output (minus last line, the one starting with `Result: [`), sort and update [plugins.txt](plugins.txt)

## Docker Hub Automated Build
* Me on [docker hub](https://hub.docker.com/r/shoepping/jenkins-custom/)
* The build makes use of [post push hook](hooks/post_push)
* [Reference](https://docs.docker.com/docker-cloud/builds/advanced/)
