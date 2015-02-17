## Annotations

@Bean
* Indicates that a method produces a bean to be managed by the Spring container. 

	@Bean
	public MyBean myBean() {
		// instantiate and configure MyBean obj
		return obj;
	}

	@Bean(name={"b1","b2"}) // bean available as 'b1' and 'b2', but not 'myBean'
	public MyBean myBean() {
		// instantiate and configure MyBean obj
		return obj;
	}

@DependsOn
