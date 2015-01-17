Packer
======

## Big Picture ##

* Packer is a tool for 
	* creating identical machine images 
	* for multiple platforms 
	* from a single source configuration

### Template ###

* The configuration file used to define 
	* what image we want built 
	* how we want to build it
* The format of a template is simple JSON

### Provisioner ###

* Install software in the image

### Builder ###

* Ouput the image in a usable format
	* Amazon
	* Virtual Box
	* ...

## Template

	{
		"description" : "description", 
		"builders" : [
			{
				"type": "virtualbox-iso",
				"guest_os_type": "Ubuntu_64",
				"iso_url": "http://releases.ubuntu.com/12.04/ubuntu-12.04.5-server-amd64.iso",
				"iso_checksum": "769474248a3897f4865817446f9a4a53",
				"iso_checksum_type": "md5",
				"ssh_username": "packer",
				"ssh_password": "packer",
				"ssh_wait_timeout": "30s",
				"shutdown_command": "echo 'packer' | sudo -S shutdown -P now"
			}
		],
		"provisioners" : [
			{
				"type":"shell",
				"script":"setup.sh"
			}
		]
	}

## Installation

Packer is distributed as a binary package.

* Download Packer from https://www.packer.io/downloads.html
* Unzip the Packer distributable in a directory
* Add the folder to the path

	$ wget https://dl.bintray.com/mitchellh/packer packer_0.7.5_linux_amd64.zip




## Commands

	packer build

## Builders ##

* Virtuabox
	* virtualbox-iso
		* Starts from an ISO file, creates a brand new VirtualBox VM, installs an OS, provisions software within the OS, then exports that machine to create an image. This is best for people who want to start from scratch.
	* virtualbox-ovf
		* This builder imports an existing OVF/OVA file, runs provisioners on top of that VM, and exports that machine to create an image. This is best if you have an existing VirtualBox VM export you want to use as the source. As an additional benefit, you can feed the artifact of this builder back into itself to iterate on a machine.


## Examples ##

### A Wordpress Machine

Type this file

	TBD

Verify the file

	$ packer validate machine.json
	Template validated successfully.

## Problems ##

	$ packer build machine.json
	virtualbox-iso output will be in this color.

	Build 'virtualbox-iso' errored: Error reading version for guest additions download: VirtualBox is not properly setup: WARNING: The vboxdrv kernel module is not loaded. Either there is no module
		 available for the current kernel (3.13.0-35-generic) or it failed to
		 load. Please recompile the kernel module and install it by

		   sudo /etc/init.d/vboxdrv setup

		 You will not be able to start VMs until this problem is fixed.
	4.3.14r95030

	==> Some builds didn't complete successfully and had errors:
	--> virtualbox-iso: Error reading version for guest additions download: VirtualBox is not properly setup: WARNING: The vboxdrv kernel module is not loaded. Either there is no module
		 available for the current kernel (3.13.0-35-generic) or it failed to
		 load. Please recompile the kernel module and install it by

		   sudo /etc/init.d/vboxdrv setup

		 You will not be able to start VMs until this problem is fixed.
	4.3.14r95030

	==> Builds finished but no artifacts were created.
	danidemi@ubuntu-desk-box:~/Gits/sitebox$ sudo /etc/init.d/vboxdrv setup
	[sudo] password for danidemi: 
	Stopping VirtualBox kernel modules ...done.
	Uninstalling old VirtualBox DKMS kernel modules ...done.
	Trying to register the VirtualBox kernel modules using DKMS ...done.
	Starting VirtualBox kernel modules ...done.

