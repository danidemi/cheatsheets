# Logback

## Sample Config File

    <?xml version="1.0" encoding="UTF-8"?>
    <configuration>

        <appender name="console" class="ch.qos.logback.core.ConsoleAppender">
            <target>System.out</target>
            <withJansi>false</withJansi>
            <encoder>
                <pattern>%d{mm:ss.SSS} %-5p [%-31t] [%-54logger{0}] %marker%m%ex{full} - %logger - %F:%L%n</pattern>
                <!-- this quadruples logging throughput risking to miss logs on unexpected exit -->
                <immediateFlush>false</immediateFlush>
                <!-- this prints out the pattern at the head of the file -->
                <outputPatternAsHeader>true</outputPatternAsHeader>
            </encoder>
        </appender>

        <appender name="file" class="ch.qos.logback.core.rolling.RollingFileAppender">
            <file>/var/log/miserve.log</file>
            <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
                <!-- daily rollover -->
                <fileNamePattern>miserve.%d{yyyy-MM-dd}.%i.log.zip</fileNamePattern>

                <!-- keep 30 days' worth of history capped at 3GB total size -->
                <maxFileSize>100MB</maxFileSize>
                <maxHistory>30</maxHistory>
                <totalSizeCap>3GB</totalSizeCap>

            </rollingPolicy>

            <encoder>
                <pattern>%-4relative [%thread] %-5level %logger{35} - %msg%n</pattern>
            </encoder>
        </appender>


        <root level="ERROR">
            <appender-ref ref="console, file" />
        </root>

        <logger name="org.apache.tomcat" level="WARN" />
        <logger name="org.springframework.security" level="ALL" />

    </configuration>

## Patterns

Example

    %c %l

* c{length}
* lo{length}
* logger{length}
    * name of logger
* C{length}
* class{length}
    * Outputs the fully-qualified class name of the caller issuing the logging request.
* contextName
* cn
    * Outputs the name of the logger context
* d{pattern}
* date{pattern}
* d{pattern, timezone}
* date{pattern, timezone}
    * Used to output the date of the logging event.
        * %d
        * %date
        * %date{ISO8601}
        * %date{HH:mm:ss.SSS}
        * %date{dd MMM yyyy;HH:mm:ss.SSS}
* F / file
    * The file where the log is originating from
* caller{depth}
* caller{depthStart..depthEnd}
* caller{depth, evaluator-1, ... evaluator-n}
* caller{depthStart..depthEnd, evaluator-1, ... evaluator-n}
    * Stack info
* L / line
    * Outputs the line number from where the logging request was issued.
* m / msg / message
    * Outputs the application-supplied message associated with the logging event.
* M / method
    * Outputs the method name where the logging request was issued.
* n
    * Outputs the platform dependent line separator character or characters
* p / le / level
    * Outputs the level of the logging event.
* r / relative
    * Outputs the number of milliseconds elapsed since the start of the application until the creation of the logging event.
* t / thread
    * Outputs the name of the thread
* X{key:-defaultVal}
* mdc{key:-defaultVal}
    * Outputs the MDC (mapped diagnostic context)
* marker
    * Outputs the marker associated with the logger request.

## Variable Sostitution

### Definition

Directly in logback.xml

    <property name="THE_VARIABLE_NAME" value="THE_VALUE" />
    <variable name="THE_VARIABLE_NAME" value="THE_VALUE" />

From the command line

    java -DTHE_VARIABLE_NAME="THE_VALUE" MyApp

From a .properties file

    <property file="src/logback.properties" />

and the files...

    # Each line a logback variable
    THE_VARIABLE_NAME=THE_VALUE

From a .properties in the classpath

    <property resource="logback.properties" />

and the file in the classpath...

    # Each line a logback variable
    THE_VARIABLE_NAME=THE_VALUE

### Use

    <property name="PATH" value="/usr/log" />

    <appender>
        <file>${PATH}/app.log</file>
    </appender>

## References
* Variable Sostitution
