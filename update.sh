# !/bin/bash

git stash

git pull --rebase

git stash pop

bundle exec rake assets:precompile RAILS_ENV=production

touch tmp/restart.txt

