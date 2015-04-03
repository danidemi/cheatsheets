## Apache Felix

## Big Picture

 * The Felix framework distribution comes with three bundles
	* located in the bundle/ directory of the framework distribution installation directory.
		* Gogo Runtime (core command processing functionality), 
		* Gogo Shell (text-based shell user interface), 
		* Gogo Command (basic set of commands), 
		* Bundle Repository (a bundle repository service). 
			* provides access to other bundles for easy installation. 
			* "obr:* scope"

## Installation

Install Felix this way

	sudo mkdir /opt/felix
	cd /opt/felix
	sudo wget http://download.nextag.com/apache//felix/org.apache.felix.main.distribution-4.6.0.tar.gz
	sudo tar xvf org.apache.felix.main.distribution-4.6.0.tar.gz

## Apache Felix Gogo shell

	cd felix-framework-4.6.0/
	java -jar bin/felix.jar
	
### Basic commands

	* `lb`
		* list bundles
	* `help {command}`
		* print the help for a command
	* `start {n}`
		* start bundle n
	* `stop {n}`
		* stop bundle n
	* `stop 0`
		* stop and exit Felix
