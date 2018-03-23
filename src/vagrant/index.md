Vagrant
=======

Why Vagrant
-----------
Vagrant is a tool for building and managing virtual machine environments 
in a single workflow. 

With an easy-to-use workflow and focus on automation, 
Vagrant lowers development environment setup time, 
increases production parity, 
and makes the "works on my machine" excuse a relic of the past.

To achieve its magic, 
Vagrant stands on the shoulders of giants. 
Machines are provisioned on top of VirtualBox, 
VMware, AWS, or any other provider. 
Then, industry-standard provisioning tools such as shell scripts, 
Chef, or Puppet, 
can automatically install and configure software on the virtual machine.

Installation
------------

Follow the instructions published on the [Vagrant Guide](https://www.vagrantup.com/docs/installation/)

Quick Start
-----------

    $ mkdir vagrant-quick-start
    $ cd vagrant-quick-start
    $ vagrant init hashicorp/precise64
    $ vagrant up
    
Slowly downloads the base vagrant box if not available locally and starts it up.

    > vagrant up
    Bringing machine 'default' up with 'virtualbox' provider...
    ==> default: Box 'hashicorp/precise64' could not be found. Attempting to find and install...
        default: Box Provider: virtualbox
        default: Box Version: >= 0
    ==> default: Loading metadata for box 'hashicorp/precise64'
        default: URL: https://vagrantcloud.com/hashicorp/precise64
    ==> default: Adding box 'hashicorp/precise64' (v1.1.0) for provider: virtualbox
        default: Downloading: https://vagrantcloud.com/hashicorp/boxes/precise64/versions/1.1.0/providers/virtualbox.box
        default: Progress: 0% (Rate: 106k/s, Estimated time remaining: 0:52:32)
        
Connect through ssh, do what you want then disconnect.

    vagrant ssh
    <do what you prefer>
    <exit>
    vagrant halt
    
General
-------

List the available boxes

    vagrant box list
    
Completelly remove the box

    vagrant box remove     

Reload the machine after a change in the config
    
    vagrant reload     
    

Workflow
--------

Create a folder where the `Vagrant` file will be stored. 
You can use an already existing folder if you prefer.

Let Vagrant create a base Vagrant config for you. 
By default, if you don't specify any box, "base" box is used. 

__???__ What is "base" box exactly ? Still don't know.

    vagrant init
    
By default, 
Vagrant shares your project directory (remember, that is the one with the Vagrantfile) 
to the /vagrant directory in your guest machine.

Note that when you vagrant ssh into your machine, 
you're in /home/vagrant. 
/home/vagrant is a different directory from the synced /vagrant directory.

Vagrant has built-in support for automated provisioning. 
Using this feature, Vagrant will automatically install software when you vagrant up 
so that the guest machine can be repeatably created and ready-to-use.

__!!!__ Naming the created vbox machine: 
<https://stackoverflow.com/questions/17845637/how-to-change-vagrant-default-machine-name#20431791>
    
