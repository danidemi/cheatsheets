### Update a single package.

`apt-get install --only-upgrade <packagename>`

### Upgrade all packages.

`apt-get upgrade`

### List of installed packages.

`apt --installed list`

### List of repositories.

`/etc/apt/sources.list`
`/etc/apt/sources.list.d/*.list`

Execute `sudo apt-get update` to tell APT to reload the list.

`grep` can be used to find which `.list` file contains a specific repository.

`grep '<search term>' *.list`

# Reference

http://www.cyberciti.biz/faq/unix-linux-finding-files-by-content/
https://help.ubuntu.com/community/Repositories/CommandLine
