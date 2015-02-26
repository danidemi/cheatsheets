## Fuse Deploy OSGI

### Hot Deployment

Red Hat JBoss Fuse monitors JAR files in the 
`InstallDir/deploy` directory and hot deploys everything in this directory. 
Each time a JAR file is copied to this directory, 
it is installed in the runtime and also started. 
You can subsequently update or delete the JARs, and the changes are handled automatically.

For instance, if we deploy there the service-tutorial, it prints

	JBossFuse:karaf@root> service started

Then `list` to discover the id of the deployed bundle.

	[ 251] [Active     ] [            ] [       ] [   60] Danidemi's OSGi tutorial - Service Example (1.0.1)
	[ 252] [Active     ] [            ] [       ] [   60] Danidemi's OSGi tutorial - Service Client (1.0.1)

Then `stop 251` prints...

	service stopped
	Ex1: Service of type com.danidemi.tutorial.osgi.dictionaryservice.DictionaryService unregistered.



### Manual Deployment

### References

https://access.redhat.com/documentation/en-US/Red_Hat_JBoss_Fuse/6.0/html/Deploying_into_the_Container/files/PartOsgi.html
