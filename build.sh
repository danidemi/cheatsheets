#!/bin/bash +x

# You need these to build it...
# sudo apt-get install pandoc
# sudo apt-get install graphviz
# sudo apt-get install imagemagik

function list(){
	local LINE=""
	while read p; do
		LINE="${LINE} $p"
	done <$2
	local  __resultvar=$1
	eval $__resultvar="'$LINE'"
}

function list_filenames(){
	local LINE=""
	local filename
	while read p; do
		if [ -f $p ]; then
			filename=$(basename "$p"); LINE="${LINE} ${3}${filename}"
		fi
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
function plantuml_2_png(){
	echo "convert all .plantuml to .png from $1 to $2"
	find $1 -iname '*.plantuml' | while read uml; do
		echo "converting ${uml} to $2"
		plantuml -o $2 ${uml}
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

# $1: index file
# $2: sub folder
function build_html(){

	# pick only the files needed
	mkdir -p build/picked
	rm -rf build/picked/*
	while read p; do
		cp $p build/picked
	done <$1	
	
	list_filenames FILES $1 "build/picked/"
	echo "picked files:"
	echo "$FILES"
	

	local SUBFOLDER=$2

	#local FILES
	#list FILES $1

	# build HTML version
	# ===================================
	
	mkdir -p build/${SUBFOLDER}/html
	
	# convert all .odg to .png
	odg_2_png src/ build/${SUBFOLDER}/html
	
	# convert all .plantuml to .png
	plantuml_2_png src/ ${PWD}/build/${SUBFOLDER}/html
	
	# copy all .png
	copy_png src/ build/${SUBFOLDER}/html
	
	# resize all
	resize build/${SUBFOLDER}/html 700
	
	# build html
	mkdir -p build/${SUBFOLDER}/html/
	cp style/*.css build/${SUBFOLDER}/html/
	pandoc --standalone --smart --toc --toc-depth=3 --css=pandoc.css -o build/${SUBFOLDER}/html/index.html ${FILES}
		
}

# $1: index file
# $2: sub folder
function build_epub(){

	echo "Building EPUB from $1 into $2"
	
	local SUBFOLDER=$2
	mkdir -p build/${SUBFOLDER}/epub
	
	# pick only the files needed
	rm -rf build/${SUBFOLDER}/epub/*
	while read p; do
		cp $p build/${SUBFOLDER}/epub/
	done <$1		
	
	# convert all .odg to .png
	odg_2_png src/ build/${SUBFOLDER}/epub
	
	# copy all .png
	copy_png src/ build/${SUBFOLDER}/epub
	
	# resize all
	resize build/${SUBFOLDER}/epub 400
	
	list_filenames FILES $1 ""
	echo "########################################\n$FILES"	
	
	# build epub
	pushd build/${SUBFOLDER}/epub
	pandoc --standalone --smart --toc --toc-depth=3 -o cheatsheets.epub $FILES
	popd
	
	find build/${SUBFOLDER}/epub -type f | grep -v '\.epub$' | xargs rm
}

function build_clean(){
	# clean all
	# ===================================
	mkdir -p build
	rm -rf build/*
}


mkdir -p build

build_clean
build_epub "docker.index" docker
build_html "docker.index" docker
build_epub "maven.index" maven
build_html "maven.index" maven
build_epub "spring-social.index" spring-social
build_html "spring-social.index" spring-social
build_epub "html-full.index" full
build_html "html-full.index" full

mkdir -p website
rm -rf website
mkdir -p website
mv ./build/docker ./website/docker
mv ./build/maven ./website/maven
mv ./build/full ./website/full


	
# references
# http://www.fmwconcepts.com/imagemagick/tidbits/image.php#resize

