#!/bin/bash -x

# You need these to build it...
# sudo apt-get install pandoc

mkdir -p build

# check grammar building a text only version
pandoc -S -o build/cheatsheets.txt \
	./src/title.yml \
	./src/docker/docker_cheat_sheet.md \
	./src/packer/packer.md \
	./src/tomcat/tomcat_cheat_sheet.md \
	./src/networking/networking_cheat_sheet.md

#cat build/cheatsheets.txt | aspell -a > build/report_aspell.txt

# converts images
#soffice --convert-to png docker/linked_containers.odg --outdir docker/ --headless

# convert all .odg to .png
echo "convert all .odg to .png"
find src/ -iname '*.odg' | while read odg; do
	soffice --convert-to png ${odg} --outdir build/html --headless
done

# copy all .png
echo "copy all .png"
find src/ -iname '*.png' | while read png; do
	cp ${png} build/html
done

# resize all
echo "resize all"
find build/ -iname '*.png' | while read png; do
	echo "computing"
	H=$(convert ${png} -format "%[h]" info:)
	W=$(convert ${png} -format "%[w]" info:)
	MAX=$(convert ${png} -format "%[fx:max(w,h)]" info:)
	echo ${png}
	echo "h=$H w=$W max=$MAX"
	REDUX=$(bc <<< "scale=3; 1/($MAX/700)")
	echo "ratio=$REDUX"
	H=$(bc<<<"scale=0; $REDUX * $H")
	W=$(bc<<<"scale=0; $REDUX * $W")
	echo "h=$H w=$W"
	convert ${png} -background white -gravity center -resize ${W}x${H} -extent ${W}x${H} ${png}
done


# build epub
pandoc -S -o build/cheatsheets.epub \
	./src/title.yml \
	./src/docker/docker_cheat_sheet.md \
	./src/packer/packer.md \
	./src/tomcat/tomcat_cheat_sheet.md \
	./src/networking/networking_cheat_sheet.md

# build html
mkdir -p build/html/
cp style/*.css build/html/
pandoc --standalone --smart --toc --toc-depth=3 --css=pandoc.css -o build/html/cheatsheets.html \
	./src/title.yml \
	./src/docker/docker_cheat_sheet.md \
	./src/packer/packer.md \
	./src/tomcat/tomcat_cheat_sheet.md \
	./src/networking/networking_cheat_sheet.md
	
# references
# http://www.fmwconcepts.com/imagemagick/tidbits/image.php#resize

