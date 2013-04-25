#!/usr/bin/env bash
git checkout master
rm -r _site
jekyll
git checkout gh-pages
rm -r !(_site)
mv _site/* ./
rmdir _site
