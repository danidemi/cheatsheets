Ansible
=======

# Single command

    ansible atlanta -a "<command>" -f <forks>

# Single module

    $ ansible <group> -m <module> -a "<params>"
    $ ansible atlanta -m copy -a "src=/etc/hosts dest=/tmp/hosts"