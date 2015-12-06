# Overview

## Security

### Enabling
If Spring Security is on the classpath then web applications will be secure by default with ‘basic’ authentication on all HTTP endpoints.

### Default Implementation
The default AuthenticationManager has a single user (‘user’ username and random password, printed at INFO level when the application starts up).
Ensure that the org.springframework.boot.autoconfigure.security category is set to log INFO messages.
You can change the password by providing a security.user.password. This and other useful properties are externalized via SecurityProperties (properties prefix "security").

### Customization
To switch off the default web security configuration completely you can 
* add a bean with @EnableWebSecurity (this does not disable the authentication manager configuration). 
* To customize it you normally use external properties and beans of type WebSecurityConfigurerAdapter (e.g. to add form-based login). 

To also switch off the authentication manager configuration you can 
* add a bean of type AuthenticationManager, 
* or else configure the global AuthenticationManager by autowiring an AuthenticationManagerBuilder into a method in one of your @Configuration classes. 
There are several secure applications in the Spring Boot samples to get you started with common use cases.
