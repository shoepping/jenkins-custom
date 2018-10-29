
/*
   Author: Sam Gleske (https://github.com/samrocketman)
   Configures the markup formatter in global security settings.
   https://github.com/samrocketman/jenkins-bootstrap-slack/blob/master/scripts/configure-markup-formatter.groovy
 */

import hudson.markup.RawHtmlMarkupFormatter
import jenkins.model.Jenkins

Jenkins.instance.setMarkupFormatter(new RawHtmlMarkupFormatter(false))
Jenkins.instance.save()

println 'Markup formatter configured.'
