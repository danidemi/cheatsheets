## Ant

### Macro

Quick example of a macro

	<macrodef name="testing">
	   <attribute name="v" default="NOT SET"/>
	   <element name="some-tasks" optional="yes"/>
	   <sequential>
	      <echo>v is @{v}</echo>
	      <some-tasks/>
	   </sequential>
	</macrodef>
	
	<testing v="This is v">
	   <some-tasks>
	      <echo>this is a test</echo>
	   </some-tasks>
	</testing>
	
### Paths & co

	<path id="{path identifier, used to reference this path}">
	
		<!-- include another path -->
		<path refid="base.path"/>
		
		<!-- to include a piece of path from a string -->
		<pathelement path="/path/to/file2.jar:/path/to/class2;/path/to/class3" />
		
		<!-- a specific jar -->
		<pathelement location="/path/to/file3.jar" />
		
		<!-- 1st entry of a complex path defined elsewhere -->
		<first>
			<path refid="complex.path"/>
		</first>
	</path>