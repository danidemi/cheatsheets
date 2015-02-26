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


