# OGNL Object-Graph Navigation Language

## Simple expressions:

* Variable Expressions: ${...}

	/*
	 * Access to properties using the point (.). Equivalent to calling property getters.
	 */
	${person.father.name}
	
	/*
	 * Access to properties can also be made by using brackets ([]) and writing 
	 * the name of the property as a variable or between single quotes.
	 */
	${person['father']['name']}
	
	/*
	 * If the object is a map, both dot and bracket syntax will be equivalent to 
	 * executing a call on its get(...) method.
	 */
	${countriesByCode.ES}
	${personsByName['Stephen Zucchini'].age}
	
	/*
	 * Indexed access to arrays or collections is also performed with brackets, 
	 * writing the index without quotes.
	 */
	${personsArray[0].name}
	
	/*
	 * Methods can be called, even with arguments.
	 */
	${person.createCompleteName()}
	${person.createCompleteNameWithSeparator('-')}

* Selection Variable Expressions: *{...}
* Message Expressions: #{...}
  * Look up in a context.
  * Can use parameters defined in the bundle following the `java.text.MessageFormat standard syntax`
  
	<p th:utext="#{home.welcome(${session.user.name})}">
	
	home.welcome=¡Bienvenido a nuestra tienda de comestibles, {0}!
	
  * Even the key can be a variable
  
	<p th:utext="#{${welcomeMsgKey}(${session.user.name})}">
  
* Link URL Expressions: @{...}

	<!-- Will produce 'http://localhost:8080/gtvg/order/details?orderId=3' (plus rewriting) -->
	<a href="details.html" 
	   th:href="@{http://localhost:8080/gtvg/order/details(orderId=${o.id})}">view</a>
	   
	<!-- Will produce '/gtvg/order/details?orderId=3' (plus rewriting) -->
	<a href="details.html" th:href="@{/order/details(orderId=${o.id})}">view</a>
	
	<!-- Will produce '/gtvg/order/3/details' (plus rewriting) -->
	<a href="details.html" th:href="@{/order/{orderId}/details(orderId=${o.id})}">view</a>
	
	<!-- Will produce the link built using the value of 'url' variable -->
	<a th:href="@{${url}(orderId=${o.id})}">view</a>

## Literals
* Text literals: 'one text', 'Another one!',…
* Number literals: 0, 34, 3.0, 12.3,…
* Boolean literals: true, false
* Null literal: null
* Literal tokens: one, sometext, main,…

## Text operations
* String concatenation: +
* Literal substitutions: |The name is ${name}|


## Arithmetic operations
* Binary operators: +, -, *, /, %
* Minus sign (unary operator): -

## Boolean operations
* Binary operators: and, or
* Boolean negation (unary operator): !, not

## Comparisons and equality
* Comparators: >, <, >=, <= (gt, lt, ge, le)
* Equality operators: ==, != (eq, ne)

## Conditional operators
* If-then: (if) ? (then)
* If-then-else: (if) ? (then) : (else)
* Default: (value) ?: (defaultvalue)