## Services

Services are registered into BundleContext and made available to other bundles.

* Registration
	* Provide a interface, implemented by the service,
	* an object actually implementing it
	* a set (possibly empty) of properties for the service

* ServiceListeners
	* informed when a service became available / unavailable
	* ServiceListener
		* public void serviceChanged(ServiceEvent event);
	* ServiceEvent
		* REGISTERED
			* The service is available.
		* UNREGISTERING
			* The service is going to be unavailable.
		* MODIFIED
			* Service's properties changed.
		* MODIFIED_ENDMATCH
			* The new Service's properties do not longer match the filter.

## Best Practices

* One Maven project with API (mostly interfaces)
* One Maven project for each "provider" of the API.
    * In general, a provider bundle should export the API it provides;
    exporting this package is a highly recommended best practice, it makes a lot of things work better later on.

## References

* <http://enroute.osgi.org/qs/410-exercise-service.html>
* <http://blog.knowhowlab.org/2010/10/osgi-tutorial-4-ways-to-activate-code.html>
* <http://www.ibm.com/developerworks/library/ws-osgi-spring1/index.html>
* <http://www.knopflerfish.org/osgi_service_tutorial.html>
    * Nice, explains how to use service factories!
* <https://access.redhat.com/documentation/en-US/Red_Hat_JBoss_Fuse/6.0/html/Deploying_into_the_Container/files/DeploySimple-Publish.html>
    * Using Blueprints, showing available services