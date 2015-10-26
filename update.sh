# !/bin/bash

git stash

git pull

git stash pop

bundle exec rake assets:precompile RAILS_ENV=production

touch tmp/restart.txt

