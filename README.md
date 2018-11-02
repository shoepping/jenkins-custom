# Jenkins pre-configured with plugins

## How to update plugins
* Execute script [update_plugins.groovy](tools/update_plugins.groovy) in [jenkins](http://jenkins.example.org/script)
* Execute script [list_plugins.groovy](tools/list_plugins.groovy) in [jenkins](http://jenkins.example.org/script)
* Copy above script output (minus last line, the one starting with `Result: [`), sort and update [plugins.txt](plugins.txt)

## Docker Hub Automated Build
* The build makes use of [post push hook](hooks/post_push)
* [Reference](https://docs.docker.com/docker-cloud/builds/advanced/)
