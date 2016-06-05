# Site Plugin

* site:site 

    * is used generate a site for a **single project**. Note that links between module sites in a multi module build will not work, since local build directory structure doesn't match deployed site.

* site:deploy 

    * is used to deploy the generated site using Wagon supported protocol to the site URL specified in the <distributionManagement> section of the POM.

* site:run 

    * starts the site up, rendering documents as requested for faster editing. It uses Jetty as the web server.

* site:stage 

    * generates a site in a local staging or mock directory based on the site URL specified in the <distributionManagement> section of the POM. It can be used to test that links between module sites in a multi module build works. To preview the whole tree of a multi-module site, you can use the[ site:stage](http://maven.apache.org/plugins/maven-site-plugin/stage-mojo.html) goal. This will copy individual sites to their proper place at the staging location.

* site:stage-deploy 

    * deploys the generated site to a staging or mock directory to the site URL specified in the <distributionManagement> section of the POM.

* site:attach-descriptor 

    * adds the site descriptor (site.xml) to the list of files to be installed/deployed. For more references of the site descriptor, here's a link.

* site:jar 

    * bundles the site output into a JAR so that it can be deployed to a repository.

* site:effective-site 

    * calculates the effective site descriptor, after inheritance and interpolation.
