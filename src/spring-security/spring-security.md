## WARNING
* If you require the user to have the role "BUYER" with .hasRole("BUYER") you should grant an authority called "ROLE_BUYER"!

## Big Picture

Spring Security provides security services for Java EE-based enterprise software applications. 

* Security
	* "Principal" generally means a user, device or some other system which can perform an action in your application.
		* "john@foo.baz", the user of an e-commerce website that can access the list of products he/she bought in the past.
		* "cali@roo.naz", the owner of the web site, that loads new products.
	* "Authentication" is the process of establishing a principal is who they claim to be.
		* There is an entry in the db for "john@foo.baz", containing the hash of his password. To authenticate it the system checks whether the hash of the password provided by the user matches the one stored into the db.
		* There is an entru in an internal LDAP for admins.
	* "Authorization" (or "access-control") deciding whether a principal is allowed to perform an action.
		* "john@foo.baz" tried to access the url of the page to load new products. It should not be allowed because he's not an administrator.
* Supports
	* HTTP BASIC authentication headers, IETF RFC-based standard
	* HTTP Digest authentication headers, IETF RFC-based standard
	* HTTP X.509 client certificate exchange, IETF RFC-based standard
	* LDAP
	* Form-based authentication
	* OpenID authentication
	* Authentication based on pre-established request headers
	* JA-SIG Central Authentication Service, aka CAS
	* Transparent authentication context propagation for Remote Method Invocation (RMI) and HttpInvoker (a Spring remoting protocol)
	* Automatic "remember-me" authentication (the “tick the box to be remembered”)
	* Anonymous authentication
	* Run-as authentication
	* Java Authentication and Authorization Service (JAAS)
	* JEE container autentication
	* Kerberos
	* Lot of 3rd party systems
	* Your own authentication systems

### Architecture

#### Model.

##### Authentication
Represents the token for an authentication request or for an authenticated principal. Please note that this is both used as an authentication request and for already authenticated pricipals!
Contains the Principal.
Contains the Principal’s GrantedAuthorities.

##### AuthenticationManager
The main interface which provides authentication services in Spring Security is the AuthenticationManager. Usually an instance of Spring Security’s ProviderManager class.

* Authentication authenticate(Authentication authentication) throws AuthenticationException
	* Attempts to authenticate the passed Authentication object, returning a fully populated Authentication object (including granted authorities) if successful. An AuthenticationManager must honour the following contract concerning exceptions:
		* A DisabledException must be thrown if an account is disabled and the AuthenticationManager can test for this state.
		* A LockedException must be thrown if an account is locked and the AuthenticationManager can test for account locking.
		* A BadCredentialsException must be thrown if incorrect credentials are presented. Whilst the above exceptions are optional, an AuthenticationManager must always test credentials.
		* Exceptions should be tested for and if applicable thrown in the order expressed above (i.e. if an account is disabled or locked, the authentication request is immediately rejected and the credentials testing process is not performed). This prevents credentials being tested against disabled or locked accounts.

##### GrantedAuthority
Reflect the application-wide permissions granted to a Principal.

##### UserDetails
Represents a Principal, but in an extensible and application-specific way.
It's the adapter between your own user database and what Spring Security needs inside the SecurityContextHolder.
Quite often you will cast the UserDetails to the original object that your application provides.
Used to provide the necessary information to build an Authentication object from your application's DAOs or other source source of security data.

* Collection<? extends GrantedAuthority> getAuthorities()
* String getPassword()
* String getUsername()
* isAccountNonExpired
* boolean isAccountNonLocked()
* boolean isCredentialsNonExpired()
* boolean isEnabled()

#### Main internals.

##### SecurityContext
Interface defining the minimum security information associated with the current thread of execution.
* Authentication getAuthentication() 
        * Obtains the currently authenticated principal, or an authentication request token.
* setAuthentication(Authentication authentication)
	* Changes the currently authenticated principal, or removes the authentication information.

##### SecurityContextHolder
Stores details of the present security context of the application includes details of the principal currently using the application.
Uses a ThreadLocal.

Main spring-security extension points.

##### UserDetailsService <interface> 
[extension-point]
To create a UserDetails when passed in a String-based username (or certificate ID or the like).
Spring-security needs a way to get the details of user that is logging in regardless of how those details are stored in the system. So, one should implement this interface to specify how to retrieve the details of the user given its username. Or one can choose to use one of the implementations provided by spring-security. It's however not likely this could happen, because spring-security cannot know in advance which is the database schema you used to store users data.
http://docs.spring.io/autorepo/docs/spring-security/4.0.3.RELEASE/apidocs/org/springframework/security/core/userdetails/UserDetailsService.html

##### InMemoryUserDetailsManager --extends--> UserDetailsService 
[strategy]
Keeps Principals and GrantedAuthorities in memory.

##### JdbcDaoImpl --extends--> UserDetailsService 
[strategy]
Retrieves user details from a DB with a schema definedby spring-security.

##### ProviderManager -- extends --> AuthenticationManager
Delegates to a list of configured AuthenticationProviders

##### AuthenticationProvider
Is queried in turn to see if it can perform the authentication.
Will either throw an exception or return a fully populated Authentication object.

##### DaoAuthenticationProvider -- extends --> AuthenticationProvider
It leverages a UserDetailsService (as a DAO) in order to lookup the username, password and GrantedAuthoritys

### Annotations

* @EnableGlobalAuthentication
	* Signals that the annotated class can be used to configure a global instance of AuthenticationManagerBuilder.
* @EnableWebSecurity
	* Add this annotation to an @Configuration class to have the Spring Security configuration defined in any WebSecurityConfigurer or more likely by extending the WebSecurityConfigurerAdapter base class and overriding individual methods. A WebSecurityConfigurer configures a WebSecurity that in turn creates the FilterChainProxy known as the Spring Security Filter Chain (springSecurityFilterChain).
* @EnableGlobalMethodSecurity
	* Enables Spring Security global method security similar to the <global-method-security> xml support.
* @EnableWebMvcSecurity
	* Deprecated. Use @EnableWebSecurity instead which will automatically add the Spring MVC related Security items.

### Actual Authentication Mechanism

1. Configure a LoginUrlAuthenticationEntryPoint with the URL of the login page, just as we did above, and set it on the ExceptionTranslationFilter.
1. Implement the login page (using a JSP or MVC controller).
1. Configure an instance of UsernamePasswordAuthenticationFilter in the application context
1. Add the filter bean to your filter chain proxy (making sure you pay attention to the order).
1. The filter calls the configured AuthenticationManager to process each authentication request. 
	1. AuthenticationSuccessHandler invoked for success login
		1. SimpleUrlAuthenticationSuccessHandler
		1. SavedRequestAwareAuthenticationSuccessHandler
	1. AuthenticationFailureHandler invoked for failed login
		1. SimpleUrlAuthenticationFailureHandler
		1. ExceptionMappingAuthenticationFailureHandler
1. If authentication is successful, the resulting Authentication object will be placed into the SecurityContextHolder. 
1. The configured AuthenticationSuccessHandler will then be called to either redirect or forward the user to the appropriate destination. 
1. By default a SavedRequestAwareAuthenticationSuccessHandler is used, which means that the user will be redirected to the original destination they requested before they were asked to login.

### Set Up

Set Up

Maven dependencies

	<dependency>
		<groupId>org.springframework.security</groupId>
		<artifactId>spring-security-web</artifactId>
		<version>3.2.5.RELEASE</version>
	</dependency>
	<dependency>
		<groupId>org.springframework.security</groupId>
		<artifactId>spring-security-config</artifactId>
		<version>3.2.5.RELEASE</version>
	</dependency>

These are optional

	<dependency>
		<groupId>org.springframework.security</groupId>
		<artifactId>spring-security-openid</artifactId>
		<version>3.2.5.RELEASE</version>
	</dependency>    

Web.xml 

	<filter>
		<filter-name>springSecurityFilterChain</filter-name>
		<filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
	</filter>

	<filter-mapping>
		<filter-name>springSecurityFilterChain</filter-name>
		<url-pattern>/*</url-pattern>
	</filter-mapping>

Spring Context
This is the xml declaration...

	<beans 
	xmlns="http://www.springframework.org/schema/beans"
	      xmlns:security="http://www.springframework.org/schema/security"
	      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	      xsi:schemaLocation="
	http://www.springframework.org/schema/beans
	http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
	http://www.springframework.org/schema/security
	http://www.springframework.org/schema/security/spring-security.xsd">
	    ...
	</beans>

These are the bean definitions

	<security:http>
		<security:intercept-url pattern="/admin/**" access="ROLE_ADMIN" />
		<security:form-login />
		<security:logout />
	</security:http>

	<security:authentication-manager>
		<security:authentication-provider>
		    <security:user-service>
			<security:user name="admin" password="admin" authorities="ROLE_ADMIN"/>
		    </security:user-service>
		</security:authentication-provider>
	</security:authentication-manager>

### Namespace

login-processing-url

Maps to the filterProcessesUrl property of UsernamePasswordAuthenticationFilter. The default value is "/j_spring_security_check".
This is the URL login form has to post username and password to!

default-target-url

Maps to the defaultTargetUrl property of UsernamePasswordAuthenticationFilter. If not set, the default value is "/" (the application root). A user will be taken to this URL after logging in, provided they were not asked to login while attempting to access a secured resource, when they will be taken to the originally requested URL.

### Tag Lib

Enable HTML Content only if user comply with the given security expression.
you should have web expressions enabled in your <http> namespace configuration to make sure this service is available

	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
		<sec:authorize access="hasRole('supervisor')">

This content will only be visible to users who have
the "supervisor" authority in their list of <tt>GrantedAuthority</tt>s.

	</sec:authorize>

Enable Content only if user is authorized to access an URL.

	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
	<sec:authorize url="/admin">

This content will only be visible to users who are authorized to send requests to the "/admin" URL.

	</sec:authorize>

Access Principal

	<sec:authentication property="principal.username" />


### Web Security Expressions

You should mark use-expressions="true" in http

	<http use-expressions="true">
	    <intercept-url pattern="/admin*"
		access="hasRole('admin') and hasIpAddress('192.168.1.0/24')"/>
	    ...
	  </http>
	<!-- this is to enable expressions in JSPs with Security taglibs-->
	    <bean id="webSecurityExpressionHandler" class="org.springframework.security.web.access.expression.DefaultWebSecurityExpressionHandler">
	    </bean>     


* hasRole([role])    
	* Returns true if the current principal has the specified role.
* hasAnyRole([role1,role2])    
	* Returns true if the current principal has any of the supplied roles (given as a comma-separated list of strings)
* principal
	* Allows direct access to the principal object representing the current user
* authentication        
	* Allows direct access to the current Authentication object obtained fromthe SecurityContext
* permitAll
	* Always evaluates to true
* denyAll
	* Always evaluates to false
* isAnonymous()
	* Returns true if the current principal is an anonymous user
* isRememberMe()
	* Returns true if the current principal is a remember-me user
isAuthenticated()
	* Returns true if the user is not anonymous
isFullyAuthenticated()
	* Returns true if the user is not an anonymous or a remember-me user
hasIpAddress(“IP”)
	* True if user comes from an IP Address

### Configuring Username And Password on DB (2)
The idea is to use org.springframework.security.provisioning.JdbcUserDetailsManager that provides CRUD to the spring tables too.

	<security:authentication-manager alias="securityAuthenticationManager">

	    <!-- authorize through a specified provider -->
	    <security:authentication-provider ref="securityDbAuthenticationProvider" />
		
	</security:authentication-manager>
    
	<!-- authorize through username / password checked through a dao -->
	<!-- since we declared it explicitly, we can fully personalize it, specifying the dao -->
	<bean id="securityDbAuthenticationProvider" class="org.springframework.security.authentication.dao.DaoAuthenticationProvider">
	    <!-- the dao --!
	    <property name="userDetailsService" ref="securityDbAuthenticationManager" />
	</bean>

	<!-- this dao provides CRUD operations, so you can inject it in one of your @Controller and use it to store a UserDetail -->
	<bean id="securityDbAuthenticationManager" class="org.springframework.security.provisioning.JdbcUserDetailsManager">
	    <property name="dataSource" ref="dataSource" />
	    <property name="enableAuthorities" value="true" />
	    <property name="enableGroups" value="false" />
	    <property name="rolePrefix" value="" />
	</bean>

You should also create an implementation of UserDetails, because that’s just an interface.

	public class SimpleUserDetails implements UserDetails {
	 // ...
	}

* Pro
	* easier solution to implement if you want a bare minimum CRUD of users.
* Cons
	* use the Spring db schema, unless you don’t personalize queries
	* Retrieving Principals and Autorizations
	* Get the User in a Bean
	* The simplest way to retrieve the currently authenticated principal is via a static call to the SecurityContextHolder:

	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	if (!(authentication instanceof AnonymousAuthenticationToken)) {
	    String currentUserName = authentication.getName();
	    return currentUserName;
	}

Get the User in a Controller via @CurrentUser

	<mvc:annotation-driven>
	    <mvc:argument-resolvers>
		<bean class="org.springframework.security.web.bind.support.AuthenticationPrincipalArgumentResolver"/>
	    </mvc:argument-resolvers>
	</mvc:annotation-driven>

@CurrentUser Get the User in a Controller via automatic argument resolver

In a @Controller annotated bean, there are additional options – the principal can be defined directly as a method argument and it will be correctly resolved by the framework:

	import java.security.Principal;
	import org.springframework.stereotype.Controller;
	import org.springframework.web.bind.annotation.RequestMapping;
	import org.springframework.web.bind.annotation.RequestMethod;
	import org.springframework.web.bind.annotation.ResponseBody;
	 
	@Controller
	public class SecurityController {
	 
	    @RequestMapping(value = "/username", method = RequestMethod.GET)
	    @ResponseBody
	    public String currentUserName(Principal principal) {
		return principal.getName();
	    }
	}
	 
	@Controller
	public class SecurityController {
	 
	    @RequestMapping(value = "/username", method = RequestMethod.GET)
	    @ResponseBody
	    public String currentUserName(Authentication authentication) {
		return authentication.getName();
	    }
	}

The API of the Authentication class is very open so that the framework remains as flexible as possible. 
Because of this, the Spring Security principal can only be retrieved as an Object and needs to be casted to the correct UserDetails instance:

	UserDetails userDetails = (UserDetails) authentication.getPrincipal();
	System.out.println("User has authorities: " + userDetails.getAuthorities());

From the HTTP request

	import java.security.Principal; 
	import javax.servlet.http.HttpServletRequest;
	import org.springframework.stereotype.Controller;
	import org.springframework.web.bind.annotation.RequestMapping;
	import org.springframework.web.bind.annotation.RequestMethod;
	import org.springframework.web.bind.annotation.ResponseBody;
 
	@Controller
	public class SecurityController {
	 
	    @RequestMapping(value = "/username", method = RequestMethod.GET)
	    @ResponseBody
	    public String currentUserNameSimple(HttpServletRequest request) {
		Principal principal = request.getUserPrincipal();
		return principal.getName();
	    }
	}

Via a Custom Interface

To fully leverage the Spring dependency injection and be able to retrieve the authentication everywhere, not just in @Controller beans, we need to hide the static access behind a simple facade:

	public interface IAuthenticationFacade {
	    Authentication getAuthentication();
	}
	@Component
	public class AuthenticationFacade implements IAuthenticationFacade {
	 
	    @Override
	    public Authentication getAuthentication() {
		return SecurityContextHolder.getContext().getAuthentication();
	    }
	}

The facade exposes the Authentication object while hiding the static state and keeping the code decoupled and fully testable:

	@Controller
	public class SecurityController {
	    @Autowired
	    private IAuthenticationFacade authenticationFacade;
	 
	    @RequestMapping(value = "/username", method = RequestMethod.GET)
	    @ResponseBody
	    public String currentUserNameSimple() {
		Authentication authentication = authenticationFacade.getAuthentication();
		return authentication.getName();
	    }
	}

Get the User in JSP

The currently authenticated principal can also be access in JSP pages, by leveraging the spring security taglib support. First, we need to define the tag in the page:

	<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
	<security:authorize access="isAuthenticated()">
	    authenticated as <security:authentication property="principal.username" /> 
	</security:authorize>


References

<http://projects.spring.io/spring-security/#quick-start>
<http://docs.spring.io/spring-security/site/docs/3.2.5.RELEASE/reference/htmlsingle/#ns-config>
<http://www.baeldung.com/get-user-in-spring-security>
<http://norrisshelton.com/2014/01/14/getting-the-spring-security-principal-in-a-spring-mvc-controller-method/>




