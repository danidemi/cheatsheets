# Use Cases

## Class

Class based on expression.

	<a 
		href="lorem-ipsum.html" 
		th:class="${isAdmin}? adminclass : userclass"
	>
		Lorem Ipsum
	</a>
	
Additional classes based on expression.	
	
	<a 
		href="" 
		class="baseclass" 
		th:classappend="${isAdmin} ? adminclass : userclass"
	>
		Lorem Ipsum
	</a>	
	
## References

<http://www.thymeleaf.org/doc/tutorials/2.1/usingthymeleaf.html>
