# Configurations

## Network Timeouts

[http://maven.apache.org/guides/mini/guide-http-settings.html](http://maven.apache.org/guides/mini/guide-http-settings.html)

[http://stackoverflow.com/questions/23510525/maven-dependency-timeout-settings/27015320#27015320](http://stackoverflow.com/questions/23510525/maven-dependency-timeout-settings/27015320#27015320)

Network timeout can be set on a per server basis.

	<server>
	
	<id>ask-3rdparties</id>
	
		<configuration>
	
			<httpConfiguration>
	
				<all><!-- all | put | get | head -->
	
					<connectionTimeout>5000</connectionTimeout>
	
					<readTimeout>5000</readTimeout>
	
				</all>
	
			</httpConfiguration>
	
		</configuration>
	
	</server>
