#!/usr/bin/env bash

CheckSuccess() {
    echo -n "Was previous command successful? [y/n] "
    read ANSWER
    if [ $ANSWER != 'y' ]; then
        echo "Aborting..."
        exit
    fi
}

echo "Starting pre-build routine."

git checkout master
CheckSuccess

rm -r _site
if [ ! -e _site/ ]; then echo "'_site/' has been successfully removed"; fi
CheckSuccess

jekyll
CheckSuccess

git checkout gh-pages
CheckSuccess

shopt -s extglob
rm -r !(_site)
CheckSuccess

mv _site/* ./
[ "$(ls -A _site)" ] && echo "Something is wrong..." || echo "Looks good."
CheckSuccess

rmdir _site

echo "Pre-build complete. Ready to commit."
