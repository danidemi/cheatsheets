Cheatsheets and notes on technologies, methodologies, tools collected during various projects.

Available as [html and epub](http://danidemi.github.io/cheatsheets/), thanks to the wonderful [Pandoc](http://johnmacfarlane.net/pandoc/).

# Build

- Prepare a `.index` file containing the relative paths of the `.md`s you want to be included in a "book".
- Add a build line in the `build.sh`, specifying the index file and the name of the folder where you want the script to place the produced files. For instance, you can add `build_epub "docker.index" docker`
- Run `build.sh`


