# README

MAC
#ENV
$ brew install mecab
$ brew install mecab-ipadic

#CLONE
$ git clone git@github.com:oggata/rails-mongo-demo.git
$ bundle install

#BATCH
$ bundle exec rails runner Tasks::Batch.execute
$ bundle exec rails runner Tasks::Search.execute

#WHENEVER
$ bundle exec whenever --update-crontab

#SEED
$ bundle exec rake db:seed

#DEV_SERVER
$ bundle exec rails server

#PROD_SERVER
$ sudo service nginx start
$ bundle exec pumactl start

UBUNTU
#
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install git vim build-essential libssl-dev libreadline-dev
sudo apt-get install nodejs
sudo apt-get install -y mecab mecab-ipadic-utf8 libmecab-dev

git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

>>>>>>>>>>>>>>>>>>
vim .bash_profile
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
>>>>>>>>>>>>>>>>>>
source .bash_profile

##インストール
$ rbenv install --list
$ rbenv install 2.3.0
$ rbenv global 2.3.0

#bundlerをインストールする
$ gem install bundler

#クローンする
git clone https://github.com/oggata/rails-mongo-demo
cd rails-mongo-demo
bundle install