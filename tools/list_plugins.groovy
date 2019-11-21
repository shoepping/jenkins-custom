new ArrayList<String>(Jenkins.instance.pluginManager.plugins).sort { it.shortName }
              .each { plugin ->
                   println ("${plugin.shortName}:${plugin.version}")
              }
