# Jenkins LTS pre-configured with plugins

## About this image
* This image 
    * aims to follow latest [Jenkins LTS ](https://jenkins.io/changelog-stable/)
    * has specific [plugins.txt](./plugins.txt) installed
    * has docker installed
    * has docker compose installed

## How to install a new plugin
* Find plugin id and it's dependencies:
    * Navigate to [Jenkis plugins](https://plugins.jenkins.io/) and search for desired plugin.
    * Go to plugin page and get plugin id (hint: search for string `ID:`)
    * If the plugin has any dependencies get each depedency id and version.
* Add plugin and plugin dependencies in [plugins.txt](./plugins.txt), in alphabetically order please, with format:
    * `plugin_id:version`

## How to update plugins
* Execute script [update_plugins.groovy](tools/update_plugins.groovy) in [jenkins](http://jenkins.example.org/script)
* Execute script [list_plugins.groovy](tools/list_plugins.groovy) in [jenkins](http://jenkins.example.org/script)
* Copy above script output (minus last line, the one starting with `Result: [`), sort and update [plugins.txt](plugins.txt)

## Docker Hub Automated Build
* Me on [docker hub](https://hub.docker.com/r/shoepping/jenkins-custom/)
* The build makes use of [post push hook](hooks/post_push)
* [Reference](https://docs.docker.com/docker-cloud/builds/advanced/)
