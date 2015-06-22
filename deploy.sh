#!/bin/bash
set -e # exit with nonzero exit code if anything fails

if [ ! -z "{$TRAVIS_TAG}" ]
then
  # Create and add CNAME file for GitHub Pages
  # See: https://help.github.com/articles/about-custom-domains-for-github-pages-sites/
  cd _site
  echo "${CNAME_PRODUCTION}" > CNAME
  git config user.name "Travis CI"
  git config user.email "pascal@finette.com"
  git add .
  git commit -m "Adding CNAME"
  # Force push from the current repo's master branch to the remote
  # repo's gh-pages branch. (All previous history on the gh-pages branch
  # will be lost, since we are overwriting it.) We redirect any output to
  # /dev/null to hide any sensitive credential data that might otherwise be exposed.
  git push --force --quiet "https://${GH_TOKEN}@${GH_PRODUCTION}" master:gh-pages > /dev/null 2>&1
  echo "Deployed to ${GH_PRODUCTION} at ${CNAME_PRODUCTION}."
else
  # Create and add CNAME file for GitHub Pages
  # See: https://help.github.com/articles/about-custom-domains-for-github-pages-sites/
  cd _site
  echo "${CNAME_STAGING}" > CNAME
  git config user.name "Travis CI"
  git config user.email "pascal@finette.com"
  git add .
  git commit -m "Adding CNAME"
  # Force push from the current repo's master branch to the remote
  # repo's gh-pages branch. (All previous history on the gh-pages branch
  # will be lost, since we are overwriting it.) We redirect any output to
  # /dev/null to hide any sensitive credential data that might otherwise be exposed.
  git push --force --quiet "https://${GH_TOKEN}@${GH_STAGING}" master:gh-pages > /dev/null 2>&1
  echo "Deployed to ${GH_STAGING} at ${CNAME_STAGING}."
fi
