# Ansible

## Installation

### APT

#### Install

    sudo apt-get install ansible

#### Uninstall

    sudo apt-get purge ansible

### From Source

First time build. Sources are several Mb.

    $ sudo apt-get -y install python-setuptools
    $ sudo easy_install pip
    $ sudo pip install paramiko PyYAML Jinja2 httplib2 six
    $ git clone git://github.com/ansible/ansible.git --recursive
    $ cd ./ansible
    $ source ./hacking/env-setup

Append this line `source /opt/ansible/ansible/hacking/env-setup` to `~/.bashrc`

Example...

    danidemi@amsung-box:/tmp$ git clone git://github.com/ansible/ansible.git --recursive
    Cloning into 'ansible'...
    remote: Counting objects: 121424, done.
    remote: Compressing objects: 100% (160/160), done.
    [...]
    Submodule 'lib/ansible/modules/core' (https://github.com/ansible/ansible-modules-core) registered for path 'lib/ansible/modules/core'
    Submodule 'lib/ansible/modules/extras' (https://github.com/ansible/ansible-modules-extras) registered for path 'lib/ansible/modules/extras'
    [...]
    Checking connectivity... done.
    Submodule path 'lib/ansible/modules/extras': checked out '66b60ce7cd4441f4bad90af5ac71721c1c0c3d4f'


When updating

    $ git pull --rebase
    $ git submodule update --init --recursive