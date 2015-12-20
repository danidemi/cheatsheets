# Use Cases

## Dialects

* Standard Dialect with Thymeleaf’s standard Object-Graph Navigation Language
* SpringStandard Dialect thymeleaf-spring3 with Spring Expression Language 
* SpringStandard Dialect thymeleaf-spring4 with Spring Expression Language

## OGNL

expression simply means “get the variable called today”

	${today}

for “get the variable called user, and call its getName() method”

	${user.name} 

## Template

This is the common header, it's VALID XHTML, not just well formed!

	<!DOCTYPE html SYSTEM "http://www.thymeleaf.org/dtd/xhtml1-strict-thymeleaf-4.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml"
	      xmlns:th="http://www.thymeleaf.org">
	      
## th:text

### For messages

	<p th:text="#{home.welcome}">Welcome to our grocery store!</p>
	
Keys resolved through...

	org.thymeleaf.messageresolver.IMessageResolver
	
The default implementation is...

	org.thymeleaf.messageresolver.StandardMessageResolver
	
That expects the keys to be in `.properties` files.

* `/WEB-INF/templates/home.html`
* `/WEB-INF/templates/home_en.properties`
* `/WEB-INF/templates/home_es.properties`
* `/WEB-INF/templates/home_pt_BR.properties`
* `/WEB-INF/templates/home_<locale>.properties`
* `/WEB-INF/templates/home.properties`	
* `${execInfo.templateName}` => name of the template
* `${execInfo.now}` => date in which the rendering started

### For variables

	Today is <span th:text="${today}">
	<span th:text="'Today is' + ${today}">
	<span th:text="'|Today is ${today}|'">

## th:utext

Does not HTML escape the variable, so it's great to include HTML

	<p th:utext="#{home.welcome}">

## Available variables

* All the request attributes to the context variables map.
* A context variable called `param` containing all the request parameters.
* A context variable called `session` containing all the session attributes.
* A context variable called `application` containing all the ServletContext attributes.

## Element Attributes

One attribute, generic way using `th:attr`

	<form action="subscribe.html" th:attr="action=@{/subscribe}">
	
Multiple attribute, generic way using `th:attr`

	<img src="../../images/gtvglogo.png" th:attr="src=@{/images/gtvglogo.png},title=#{logo},alt=#{logo}" />
	
Using predefined Thymeleaf attributes

	<form action="subscribe.html" th:action="@{/subscribe}">
	
all attributes are provided...

	th:abbr 
	th:accept 	
	th:accept-charset
	th:accesskey 	
	th:action
	...
	
Special th: attributes setting more than one attribute.

* th:alt-title will set alt and title.
* th:lang-xmllang will set lang and xml:lang.
	

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
	
# Iteration

	<tr th:each="prod : ${prods}">
		<td th:text="${prod.name}">Onions</td>
		<td th:text="${prod.price}">2.41</td>
		<td th:text="${prod.inStock}? #{true} : #{false}">yes</td>
	</tr>
	
Keep the status of the iteration

	<table>
	  <tr>
	    <th>NAME</th>
	    <th>PRICE</th>
	    <th>IN STOCK</th>
	  </tr>
	  <tr th:each="prod,iterStat : ${prods}" th:class="${iterStat.odd}? 'odd'">
	    <td th:text="${prod.name}">Onions</td>
	    <td th:text="${prod.price}">2.41</td>
	    <td th:text="${prod.inStock}? #{true} : #{false}">yes</td>
	  </tr>
	</table>
	

* The current iteration index, starting with 0. This is the index property.
* The current iteration index, starting with 1. This is the count property.
* The total amount of elements in the iterated variable. This is the size property.
* The iter variable for each iteration. This is the current property.
* Whether the current iteration is even or odd. These are the even/odd boolean properties.
* Whether the current iteration is the first one. This is the first boolean property.
* Whether the current iteration is the last one. This is the last boolean property.
	
	
## References

<http://www.thymeleaf.org/doc/tutorials/2.1/usingthymeleaf.html>
