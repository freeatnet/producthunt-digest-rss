#!/usr/bin/env bash

# load rvm ruby
source $HOME/.rvm/environments/ruby-2.3.1@producthunt-rss-digest

git pull --rebase
ruby ph.rb
git add _posts
git commit -m "Add the most recent post"
git push origin gh-pages

