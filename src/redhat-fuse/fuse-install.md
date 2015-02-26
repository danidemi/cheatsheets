## Fuse Installation

Download JBoss Fuse 6.1.0.GA Full Zip. Or See all downloads.

Make sure you have a supported JDK installed. OpenJDK or Oracle JDK 6 or 7 is required. Java 8 is not yet supported, but will be in a future release.

In Windows or Mac, you can extract the contents of the ZIP archive by double clicking on the ZIP file. In Linux, open a terminal window in the target machine and navigate to where the ZIP file was downloaded. Extract the ZIP file by executing the following command:

unzip jboss-fuse-6.1.0.GA-full_zip.zip
cd jboss-fuse-6.1.0.redhat-379

verify that you are using a jdk 1.6-1.7 with java -version
verify that you've correctly set JAVA_HOME to the corresponding jdk

bin/fuse

The first time JBoss Fuse is started you must configure an administrator user. In the Fuse shell execute the following command

esb:create-admin-user

And type in a username and password.

Using the web console Open a web browser and visit http://localhost:8181. Login using the administrator user you created.

You can now (optionally) install the Integration Stack for JBoss Developer Studio. 
This provides IDE support for developing JBoss Fuse applications. For more details, see the installation instructions.

For more details, view the Product Documentation.
