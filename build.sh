#!/bin/bash +x

function list(){
	local LINE=""
	while read p; do
		LINE="${LINE} $p"
	done <$2
	local  __resultvar=$1
	eval $__resultvar="'$LINE'"
}

# $1:	source folder
# $2:	out folder
function odg_2_png(){
	echo "convert all .odg to .png from $1 to $2"
	find $1 -iname '*.odg' | while read odg; do
		soffice --convert-to png ${odg} --outdir $2 --headless
	done
}

# $1:	source folder
# $2:	out folder
function copy_png(){
	echo "copy all .png from $1 to $2"
	find $1 -iname '*.png' | while read png; do
		cp ${png} $2
	done
}

# $1:	source folder
# $2:	max dimension in pixel
function resize(){
	echo "resize all png in $1 to max $2"
	find $1 -iname '*.png' | while read png; do
		H1=$(convert ${png} -format "%[h]" info:)
		W1=$(convert ${png} -format "%[w]" info:)
		MAX=$(convert ${png} -format "%[fx:max(w,h)]" info:)
		REDUX=$(bc <<< "scale=3; 1/($MAX/$2)")
		H2=$(bc<<<"scale=0; $REDUX * $H1")
		W2=$(bc<<<"scale=0; $REDUX * $W1")
		echo "resizing ${png} from $H1 x $W1 to $H2 x $W2" 
		convert ${png} -background white -gravity center -resize ${W2}x${H2} -extent ${W2}x${H2} ${png}
	done
}

function build_html(){
	# build HTML version
	# ===================================
	
	mkdir -p build/html
	
	# convert all .odg to .png
	odg_2_png src/ build/html
	
	# copy all .png
	copy_png src/ build/html
	
	# resize all
	resize build/html 700
	
	# build html
	mkdir -p build/html/
	cp style/*.css build/html/
	pandoc --standalone --smart --toc --toc-depth=3 --css=pandoc.css -o build/html/cheatsheets.html \
		./src/title.yml \
		./src/docker/docker_cheat_sheet.md \
		./src/packer/packer.md \
		./src/tomcat/tomcat_cheat_sheet.md \
		./src/networking/networking_cheat_sheet.md
		
	#ls | grep -v '\.lnx$' | xargs rm
		
}

function build_epub(){
	# build EPUB
	# ===================================	
	
	mkdir -p build/epub
	
	# convert all .odg to .png
	odg_2_png src/ build/epub
	
	# copy all .png
	copy_png src/ build/epub
	
	# resize all
	resize build/epub 400
	
	# build epub
	pushd build/epub
	pandoc --standalone --smart --toc --toc-depth=3 -o cheatsheets.epub \
		../../src/title.yml \
		../../src/docker/docker_cheat_sheet.md \
		../../src/packer/packer.md \
		../../src/tomcat/tomcat_cheat_sheet.md \
		../../src/networking/networking_cheat_sheet.md
	popd
	
	find build/epub -type f | grep -v '\.epub$' | xargs rm
}

function build_clean(){
	# clean all
	# ===================================
	mkdir -p build
	rm -rf build/*
}

# You need these to build it...
# sudo apt-get install pandoc

mkdir -p build

# check grammar building a text only version
# pandoc -S -o build/cheatsheets.txt \
# 	./src/title.yml \
# 	./src/docker/docker_cheat_sheet.md \
# 	./src/packer/packer.md \
# 	./src/tomcat/tomcat_cheat_sheet.md \
# 	./src/networking/networking_cheat_sheet.md

#cat build/cheatsheets.txt | aspell -a > build/report_aspell.txt

list K test.list
echo "kkk:$K"

build_clean
build_epub
build_html

	
# references
# http://www.fmwconcepts.com/imagemagick/tidbits/image.php#resize

