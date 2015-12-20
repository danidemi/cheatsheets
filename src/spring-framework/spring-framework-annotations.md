# Annotations

## Context Configuration Annotations

@Bean
* Method
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
* ???
* ???

@Autowired	
* Constructor, Field, Method	
* Declares a constructor, field, setter method, or configuration method to be autowired by type. Items annotated with @Autowired do not have to be public.

@Configurable	
* Type	
* Used with <context:springconfigured> to declare types whose properties should be injected, even if they are not instantiated by Spring. Typically used to inject the properties of domain objects.

@Order	
* Type, Method, Field	
* Defines ordering, as an alternative to implementing the org. springframework.core.Ordered interface.

@Qualifier	
* Field, Parameter, Type, Annotation Type	
* Guides autowiring to be performed by means other than by type.

@Required	
* Method (setters)	
* Specifies that a particular property must be injected or else the configuration will fail.

@Scope	
* Type	
* Specifies the scope of a bean, either singleton, prototype, request, session, or some custom scope.

## Stereotyping Annotations
@Component	
* Type	
* Generic stereotype annotation for any Spring-managed component.

@Controller	
* Type	
* Stereotypes a component as a Spring MVC controller.

@Repository	
* Type	
* Stereotypes a component as a repository. Also indicates that SQLExceptions thrown from the component's methods should be translated into Spring DataAccessExceptions.

@Service	
* Type	
* Stereotypes a component as a service.


## Spring MVC Annotations

Please, see spring-mvc.md



## Transaction Annotations
The @Transactional annotation is used along with the <tx:annotation-driven> element to declare transactional boundaries and rules as class and method metadata in Java.

@Transactional	
Method, Type	
Declares transactional boundaries and rules on a bean and/or its methods.

## JMX Annotations
These annotations, used with the <context:mbean-export> element, declare bean methods and properties as MBean operations and attributes.

@ManagedAttribute	
Method	
Used on a setter or getter method to indicate that the bean's property should be exposed as a MBean attribute.

@ManagedNotification	
Type	
Indicates a JMX notification emitted by a bean.

@ManagedNotifications	
Type	
Indicates the JMX notifications emitted by a bean.

@ManagedOperation	
Method	
Specifies that a method should be exposed as a MBean operation.

@ManagedOperationParameter	
Method	
Used to provide a description for an operation parameter.

@ManagedOperationParameters	
Method	
Provides descriptions for one or more operation parameters.

@ManagedResource	
Type	
Specifies that all instances of a class should be exposed a MBeans.

## JSR-250 Annotations
In addition to Spring's own set of annotations, Spring also supports a few of the annotations defined by JSR-250, which is the basis for the annotations used in EJB 3.

@PostConstruct	
Method	
Indicates a method to be invoked after a bean has been created and dependency injection is complete. Used to perform any initialization work necessary.

@PreDestroy	
Method	
Indicates a method to be invoked just before a bean is removed from the Spring context. Used to perform any cleanup work necessary.

@Resource	
Method, Field	
Indicates that a method or field should be injected with a named resource (by default, another bean).


## Testing Annotations
These annotations are useful for creating unit tests in the JUnit 4 style that depend on Spring beans and/or require a transactional context.


@AfterTransaction	
Method	
Used to identify a method to be invoked after a transaction has completed.

@BeforeTransaction	
Method	
Used to identify a method to be invoked before a transaction starts.

@ContextConfiguration	
Type	
Configures a Spring application context for a test.

@DirtiesContext	
Method	
Indicates that a method dirties the Spring container and thus it must be rebuilt after the test completes.

@ExpectedException	
Method	
Indicates that the test method is expected to throw a specific exception. The test will fail if the exception is not thrown.

@IfProfileValue	
Type, Method	
Indicates that the test class or method is enabled for a specific profile configuration.

@NotTransactional	
Method	
Indicates that a test method must not execute in a transactional context.

@ProfileValueSourceConfiguration	
Type	
Identifies an implementation of a profile value source. The absence of this annotation will cause profile values to be loaded from system properties.

@Repeat
Method	
Indicates that the test method must be repeated a specific number of times.

@Rollback	
Method	
Specifies whether or not the transaction for the annotated method should be rolled back or not.

@TestExecutionListeners	
Type	
Identifies zero or more test execution listeners for a test class.

@Timed	
Method	
Specifies a time limit for the test method. If the test does not complete before the time has expired, the test will fail.

@TransactionConfiguration	
Type	
Configures test classes for transactions, specifying the transaction manager and/or the default rollback rule for all test methods in a test class.

# References
<https://dzone.com/refcardz/spring-annotations>
<http://forum.spring.io/forum/spring-projects/web/55552-why-does-initbinder-method-get-called-multiple-times>