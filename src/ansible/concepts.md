Concepts
--------

# Inventory

File /etc/ansible/hosts.

    # comments too ?
    mail.example.com
    
    [webservers]
    foo.example.com
    bar.example.com
    badwolf.example.com:5309
    www[01:50].example.com
    
    [dbservers]
    one.example.com
    two.example.com
    three.example.com
    db-[a:f].example.com
    
    [connection]
    localhost              ansible_connection=local
    other1.example.com     ansible_connection=ssh        ansible_user=mpdehaan
    other2.example.com     ansible_connection=ssh        ansible_user=mdehaan
        
    [group-with-variables]
    host1 var1=80 maxRequestsPerChild=808
    host2 var1=303 maxRequestsPerChild=909  
          
    [group-with-variables:vars]
    ntp_server=ntp.atlanta.example.com
    proxy=proxy.atlanta.example.com
    
* Groups
    * Ranges of hosts
        * Host
            * Type of connection
            * User
        * Host Variables
        * Group Variables
        
# Pattern

How to choose host to work with

    ansible <pattern_goes_here> -m <module_name> -a <arguments>
    
* Pattern
    * Special Pattern
        * 'all' => all hosts
        * *  => all hosts
    * One or more groups
        * group1:group2:gorup3
    * Exclude group
        * group1:!group2
    * Intersection
        * group1:&group2

# Playbook

* Playbook
    * made of plays
        * made of tasks
            * that invoke _idempotent_ modules

# Module & Handlers

* Module
    * Idempotent
        * You can run them any number of times

* Handlers

    * React when an idempotent module actually applyed a modification
    * Handlers are what notifiers notify