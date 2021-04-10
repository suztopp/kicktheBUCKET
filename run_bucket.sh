# !/bin/bash

gem install bundler
bundle install

ruby kickthebucket.rb $1                #will run the help command line argument
