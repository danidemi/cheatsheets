## Apache Velocity

### Programmatically set up Apache Velocity with Velocity Tools

Maven

	<dependency>
		<groupId>org.apache.velocity</groupId>
		<artifactId>velocity</artifactId>
		<version>1.7</version>
	</dependency>

	<dependency>
	    <groupId>org.apache.velocity</groupId>
	    <artifactId>velocity-tools</artifactId>
	    <version>2.0</version>
	</dependency>

Code

	// references...
	// http://stackoverflow.com/questions/12080299/better-way-to-use-velocitys-generictools-in-a-standalone-app
	// https://velocity.apache.org/tools/devel/javadoc/org/apache/velocity/tools/generic/DateTool.html

	// create the Velocity engine
	VelocityEngine ve = new VelocityEngine();

	// set up the ToolManager, to easily integrate tools into Velocity
	ToolManager tm = new ToolManager();
	tm.setVelocityEngine(ve);
	tm.autoConfigure(true);

	// get the Velocity context through the ToolManager, so it will contains all the default tools
	ToolContext context = tm.createContext();

	// populate the context with some data
	context.put("myDate", new Date());
	context.put("myFirstName", "Jean");
	context.put("myLastName", "Doe");

	// render a template that includes Velocity Tools incovations
	Writer writer = new StringWriter();
	String logTag = "tag";
	String reader = "$myFirstName\n$myLastName\n$date.format('yyyy-MM-dd',$myDate)\n";
	if( ve.evaluate(context, writer, logTag, reader) ){
		System.out.println( writer.toString() );			
	}else{
		System.err.println( "Errors occurred while evaluating the template" );
	}
