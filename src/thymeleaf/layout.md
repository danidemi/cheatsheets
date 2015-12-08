# Thymeleaf Page Layouts

Thymeleaf offers three layouts systems.
* Thymeleaf Standard Layout System
  * Based on includes
* Thymeleaf Standard Layout System with selectors
  * Based on includes  
* Thymeleaf Layout Dialect
  * Based on hierarchies 
* Thymeleaf Tiles Integration
  * Based on hierarchies

## Thymeleaf Standard Layout System

Based on "inclusion".

### Main Idea

* Write a page where you include fragmests using `<div th:replace="{fragments-file-path} :: {fragment-name}">`.
* Define fragments in a HTML with `<div class="navbar navbar-inverse navbar-fixed-top" th:fragment="{fragment-name}">`
* All the templates can still be natural templates and can be viewed in a browser without a running server. 

### Example

	<body>
	    <div th:include="footer :: copy">...</div>
	</body>
	
So this is the template
	
	<!DOCTYPE html>
	<html>
	  <head>
	    ...
	  </head>
	  <body>
	    ...
	    <div th:replace="fragments/header :: header">
	      <!-- ============================================================================ -->
	      <!-- This content is only used for static prototyping purposes (natural templates)-->
	      <!-- and is therefore entirely optional, as this markup fragment will be included -->
	      <!-- from "fragments/header.html" at runtime.                                     -->
	      <!-- ============================================================================ -->
	      <div class="navbar navbar-inverse navbar-fixed-top">
	        <div class="container">
	          <div class="navbar-header">
	            <a class="navbar-brand" href="#">Static header</a>
	          </div>
	          <div class="navbar-collapse collapse">
	            <ul class="nav navbar-nav">
	              <li class="active"><a href="#">Home</a></li>
	            </ul>
	          </div>
	        </div>
	      </div>
	    </div>
	    <div class="container">
	      <div class="hero-unit">
	        <h1>Test</h1>
	        <p>
	          Welcome to the Spring MVC Quickstart application!
	          Get started quickly by signing up.
	        </p>
	        <p>
	          <a href="/signup" th:href="@{/signup}" class="btn btn-large btn-success">Sign up</a>
	        </p>
	      </div>
	      <div th:replace="fragments/footer :: footer">&copy; 2013 The Static Templates</div>
	    </div>
	    ...
	  </body>
	</html>
	
The key part is...
	
	<div th:replace="fragments/header :: header">...</div>
	
Template fragments/header.html

	<!DOCTYPE html>
	<html>
	  <head>
	    ...
	  </head>
	  <body>
	    <div class="navbar navbar-inverse navbar-fixed-top" th:fragment="header">
	      <div class="container">
	        <div class="navbar-header">
	          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".nav-collapse">
	            <span class="icon-bar"></span>
	            <span class="icon-bar"></span>
	            <span class="icon-bar"></span>
	          </button>
	          <a class="navbar-brand" href="#">My project</a>
	        </div>
	        <div class="navbar-collapse collapse">
	          <ul class="nav navbar-nav">
	            <li class="active"><a href="#" th:href="@{/}">Home</a></li>
	            <li><a href="#" th:href="@{/message}">Messages</a></li>
	            <li><a href="#" th:href="@{/task}">Tasks</a></li>
	          </ul>
	          <ul class="nav navbar-nav navbar-right">
	            <li th:if="${#authorization.expression('!isAuthenticated()')}">
	              <a href="/signin" th:href="@{/signin}">Sign in</a>
	            </li>
	            <li th:if="${#authorization.expression('isAuthenticated()')}">
	              <a href="/logout" th:href="@{/logout}">Logout</a>
	            </li>
	          </ul>
	        </div>
	      </div>
	    </div>
	  </body>
	</html>
	
## Thymeleaf Standard Layout System With Selector

	<div th:include="http://www.thymeleaf.org :: p.notice" >...</div>
	
	<div th:replace="fragments/footer :: ${#authentication.principal.isAdmin()} ? 'footer-admin' : 'footer'">
	  &copy; 2013 The Static Templates
	</div>
	
	@Bean
	public SpringTemplateEngine templateEngine() {
	    SpringTemplateEngine templateEngine = new SpringTemplateEngine();
	    templateEngine.addTemplateResolver(templateResolver());
	    templateEngine.addTemplateResolver(urlTemplateResolver());
	    templateEngine.addDialect(new SpringSecurityDialect());
	    return templateEngine;
	}
	
## Thymeleaf Layout Dialect


	<dependency>
	  <groupId>nz.net.ultraq.thymeleaf</groupId>
	  <artifactId>thymeleaf-layout-dialect</artifactId>
	  <version>1.2.1</version>
	</dependency>
	
	@Bean
	public SpringTemplateEngine templateEngine() {
	    SpringTemplateEngine templateEngine = new SpringTemplateEngine();
	    ...
	    templateEngine.addDialect(new LayoutDialect());
	    return templateEngine;
	}
	
The layout	
	
	<!DOCTYPE html>
	<html>
	  <head>
	    <!--/*  Each token will be replaced by their respective titles in the resulting page. */-->
	    <title layout:title-pattern="$DECORATOR_TITLE - $CONTENT_TITLE">Task List</title>
	    ...
	  </head>
	  <body>
	    <!--/* Standard layout can be mixed with Layout Dialect */-->
	    <div th:replace="fragments/header :: header">
	      ...
	    </div>
	    <div class="container">
	      <div layout:fragment="content">
	        <!-- ============================================================================ -->
	        <!-- This content is only used for static prototyping purposes (natural templates)-->
	        <!-- and is therefore entirely optional, as this markup fragment will be included -->
	        <!-- from "fragments/header.html" at runtime.                                     -->
	        <!-- ============================================================================ -->
	        <h1>Static content for prototyping purposes only</h1>
	        <p>
	          Lorem ipsum dolor sit amet, consectetur adipiscing elit.
	          Praesent scelerisque neque neque, ac elementum quam dignissim interdum.
	          Phasellus et placerat elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
	          Praesent scelerisque neque neque, ac elementum quam dignissim interdum.
	          Phasellus et placerat elit.
	        </p>
	      </div>
	      <div th:replace="fragments/footer :: footer">&copy; 2014 The Static Templates</div>
	    </div>
	  </body>
	</html>
	
	<div layout:fragment="content">...</div>
	
The content page...

	<!DOCTYPE html>
	<html layout:decorator="task/layout">
	  <head>
	    <title>Task List</title>
	    ...
	  </head>
	  <body>
	    <!-- /* Content of this page will be decorated by the elements of layout.html (task/layout) */ -->
	    <div layout:fragment="content">
	      <table class="table table-bordered table-striped">
	        <thead>
	          <tr>
	            <td>ID</td>
	            <td>Title</td>
	            <td>Text</td>
	            <td>Due to</td>
	          </tr>
	        </thead>
	        <tbody>
	          <tr th:if="${tasks.empty}">
	            <td colspan="4">No tasks</td>
	          </tr>
	          <tr th:each="task : ${tasks}">
	            <td th:text="${task.id}">1</td>
	            <td><a href="view.html" th:href="@{'/' + ${task.id}}" th:text="${task.title}">Title ...</a></td>
	            <td th:text="${task.text}">Text ...</td>
	            <td th:text="${#calendars.format(task.dueTo)}">July 11, 2012 2:17:16 PM CDT</td>
	          </tr>
	        </tbody>
	      </table>
	    </div>
	  </body>
	</html>
	
Key points:	
	
	<html layout:decorator="task/layout">
	
The layout to use to render this content.
	
	<div layout:fragment="content">
	
The fragment that will populate the layout.

## References
<http://www.thymeleaf.org/doc/html/Using-Thymeleaf.html#appendix-c-dom-selector-syntax>