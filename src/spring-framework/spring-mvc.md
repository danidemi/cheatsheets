# Spring MVC

## Annotations

These annotations were introduced in Spring 2.5 to make it easier to create Spring MVC applications with minimal XML configuration and without extending one of the many implementations of the Controller interface.

@Controller	
Type	
Stereotypes a component as a Spring MVC controller.

@InitBinder	
Method	
Annotates a method that customizes data binding.
A WebDataBinder instance is specific to a model attribute. 
You can verify the target model attribute a data binder is created for like this:

	@InitBinder
	public void initBinder(WebDataBinder binder) {
	    System.out.println("A binder for object: " + binder.getObjectName());
	}
	
Or...

	@InitBinder
	public void initBinder(WebDataBinder binder) {
	    System.out.println("A binder for object : " + binder.getTarget());
	}

Data binders are also used for @RequestParam's and by default an init-binder method is used for for all model attribute and request parameters. 

You can add params to the method marked as `@InitBinder`, they will be autowired by default, as...

	@InitBinder
	protected void initBinder(WebDataBinder binder, WebRequest webRequest, Locale locale) {
		System.out.println("--init binding--");
		System.out.println("web request:");
		System.out.println(Arrays.asList( webRequest.getAttributeNames(RequestAttributes.SCOPE_REQUEST) ));
		System.out.println( webRequest.getParameterMap() );
		System.out.println("validators:" + binder.getValidators());	
		System.out.println(binder.getTarget());
		binder.addValidators(new SignUpFormValidator());
		System.out.println("validators:" + binder.getValidators());
		System.out.println("--end binding--");
	} 

@ModelAttribute	
Parameter, Method	
When applied to a method, used to preload the model with the value returned from the method. When applied to a parameter, binds a model attribute to the parameter. 

@RequestMapping	
Method, Type	
Maps a URL pattern and/or HTTP method to a method or controller type.

@RequestParam	
Parameter	
Binds a request parameter to a method parameter.

@SessionAttributes	
Type	
Specifies that a model attribute should be stored in the session.