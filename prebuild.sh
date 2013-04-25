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
CheckSuccess

jekyll
CheckSuccess

git checkout gh-pages
CheckSuccess

rm -r !(_site)
CheckSuccess

mv _site/* ./
CheckSuccess

rmdir _site

echo "Pre-build complete. Ready to commit."
