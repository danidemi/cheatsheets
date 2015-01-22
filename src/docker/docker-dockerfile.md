## Dockerfile ##

	# comment
	&lt;INSTRUCTION&gt; &lt;statement&gt;

|INSTRUCTION|SYNTAX                               |Support Env Substutution|Description                                                                                                                                                                                                                                                                                |Example                                         |
|-----------|-------------------------------------|------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------|
|FROM       |FROM &lt;image&gt;[:&lt;tag&gt;]     |No                      |Base image                                                                                                                                                                                                                                                                                 |FROM ubuntu:12.04                               |
|MAINTAINER |MAINTAINER &lt;author&gt;            |No                      |Image maintainer                                                                                                                                                                                                                                                                           |MAINTAINER Kate Smith &lt;ksmith@example.com&gt;|
|RUN        |RUN &lt;command&gt;                  |No                      |The command is run in a shell - /bin/sh -c - shell form. multiple 'RUN' lines could be used for complex provisioning|apt-get update && apt-get install -y ruby ruby-dev                                                                                                                    |                                                |
|RUN        |RUN ["executable","param1", "param2"]|No                      |                                                                                                                                                                                                                                                                                           |                                                |
|CMD        |CMD ["executable","param1","param2"] |No                      |The main purpose of a CMD is to provide defaults for an executing container.                                                                                                                                                                                                               |                                                |
|CMD        |CMD ["param1","param2"]              |No                      |The main purpose of a CMD is to provide defaults for an executing container.                                                                                                                                                                                                               |                                                |
|CMD        |CMD command param1 param2            |No                      |The main purpose of a CMD is to provide defaults for an executing container.                                                                                                                                                                                                               |                                                |
|EXPOSE     |EXPOSE &lt;port&gt; [&lt;port&gt;...]|Yes                     |The EXPOSE instructions informs Docker that the container will listen on the specified network ports at runtime.                                                                                                                                                                           |                                                |
|ENV        |ENV &lt;key&gt; &lt;value&gt;        |Yes                     |Sets the environment variable &lt;key&gt; to the value &lt;value&gt;                                                                                                                                                                                                                       |                                                |
|ADD        |                                     |Yes                     |Copies new files, directories or remote file URLs from &lt;src&gt; to path &lt;dest&gt;. If &lt;src&gt; is a compressed file it will be uncompressed.                                                                                                                                      |                                                |
|COPY       |COPY &lt;src&gt;... &lt;dest&gt;     |Yes                     |copies new files or directories from &lt;src&gt; and adds them to the filesystem of the container at  the path &lt;dest&gt;. &lt;src&gt; MUST not be outside The folder where Dokerfile is. If &lt;dest&gt; terminated with "/" it is considered a folder,otherwise it's considered a file.|                                                |
|WORKDIR    |                                     |Yes                     |sets the working directory for any RUN, CMD and ENTRYPOINT instructions that follow it in the Dockerfile                                                                                                                                                                                   |                                                |
|VOLUME     |                                     |Yes                     |Will create a mount point with the specified name and mark it as holding externally mounted volumes from native host or other containers                                                                                                                                                   |                                                |
|USER       |                                     |Yes                     |Sets the user name or UID to use when running the image                                                                                                                                                                                                                                    |                                                |
|ONBUILD    |                                     |No                      |Adds to the image a trigger instruction to be executed at a later time, when the image is used as the base for another build                                                                                                                                                               |                                                |

                    












