#!/bin/bash
set -e # exit with nonzero exit code if anything fails

# clear the _site directory
rm -rf _site || exit 0;

# build site using jekyll
jekyll build && htmlproof --disable-external ./_site

# go to the out directory and create a *new* Git repo
cd _site
git init

# inside this git repo we'll pretend to be a new user
git config user.name "Travis CI"
git config user.email "pascal@finette.com"

# The first and only commit to this new Git repo contains all the
# files present with the commit message "Deploy to GitHub Pages".
git add .
git commit -m "Deploy to GitHub Pages"
