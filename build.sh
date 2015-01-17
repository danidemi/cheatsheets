#!/bin/bash

# You need these to build it...
# sudo apt-get install pandoc

mkdir -p build

# check grammar building a text only version
pandoc -S -o build/cheatsheets.txt \
	./title.yml \
	./docker/docker_cheat_sheet.md \
	./packer/packer.md \
	./tomcat/tomcat_cheat_sheet.md \
	./networking/networking_cheat_sheet.md

cat build/cheatsheets.txt | aspell -a > build/report_aspell.txt

# converts images
#soffice --convert-to png docker/linked_containers.odg --outdir docker/ --headless



# build epub
pandoc -S -o build/cheatsheets.epub \
	./title.yml \
	./docker/docker_cheat_sheet.md \
	./packer/packer.md \
	./tomcat/tomcat_cheat_sheet.md \
	./networking/networking_cheat_sheet.md

