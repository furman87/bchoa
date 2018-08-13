echo "Provisioning virtual machine..."
#Boxes don't have their timezone set.  This will ensure files and other items are timestamped correctly
sudo timedatectl set-timezone America/New_York
# Needed for docs generation.
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

#update library list to the latest and upgrage
sudo apt-get update && sudo apt-get upgrade >/dev/null

# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
echo '--------------------------------------------'
echo "Installing Ruby dependencies..."
echo '--------------------------------------------'
sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev libpcre3-dev

echo '--------------------------------------------'
echo "Installing Nginx + Passenger..."
echo '--------------------------------------------'
# sudo apt-get -y install nginx >/dev/null

# Install our PGP key and add HTTPS support for APT
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
sudo apt-get install -y apt-transport-https ca-certificates

# Add our APT repository
sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main > /etc/apt/sources.list.d/passenger.list'
sudo apt-get update

# Install Passenger + Nginx
sudo apt-get install -y nginx-extras passenger

# Fix nginx.conf file and remove default sites, add symbolic link to our nginx.conf
sudo sed -i 's/# passenger_root/passenger_root/g' /etc/nginx/nginx.conf
sudo sed -i 's/# passenger_ruby/passenger_ruby/g' /etc/nginx/nginx.conf
sudo sed -i "2i env PATH;" /etc/nginx/nginx.conf
sudo rm /etc/nginx/sites-available/default
sudo rm /etc/nginx/sites-enabled/default
sudo ln -s /vagrant/nginx.conf /etc/nginx/sites-enabled/myapp.conf

# Ruby and Rails
echo '--------------------------------------------'
echo 'Installing rbenv...'
echo '--------------------------------------------'
git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

sudo -H -u vagrant bash -i -c 'rbenv install 2.2.4'
sudo -H -u vagrant bash -i -c 'rbenv rehash'
sudo -H -u vagrant bash -i -c 'rbenv global 2.2.4'
sudo -H -u vagrant bash -i -c 'gem install bundler --no-ri --no-rdoc'
sudo -H -u vagrant bash -i -c 'rbenv rehash'

# Rails
echo '--------------------------------------------'
echo 'Installing node.js...'
echo '--------------------------------------------'
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get -y install nodejs

echo '--------------------------------------------'
echo 'Installing Rails...'
echo '--------------------------------------------'
sudo -H -u vagrant bash -i -c 'gem install rails -v 4.2.6'
sudo -H -u vagrant bash -i -c 'rbenv rehash'

echo '--------------------------------------------'
echo 'Installing ImageMagick...'
echo '--------------------------------------------'
# sudo apt-get install libpng12-dev libglib2.0-dev zlib1g-dev libbz2-dev libtiff4-dev libjpeg8-devm -y
# mkdir ~/src
# cd ~/src
# mkdir ImageMagick
# wget http://www.imagemagick.org/download/ImageMagick.tar.gz
# tar -xzvf ImageMagick.tar.gz -C ImageMagick --strip-components 1
# cd ImageMagick
# #./configure
# ./configure '--with-png=yes' '--with-jpeg=yes' '--with-jp2=yes'
# make
# sudo make install
# sudo ldconfig /usr/local/lib

# newer make instructions: 2017-12-17
# mkdir ~/src
# cd ~/src
# wget ftp://ftp.imagemagick.org/pub/ImageMagick/ImageMagick.tar.gz
# tar xvfz ImageMagick.tar.gz
# cd ImageMagick-*
# ./configure --disable-shared
# make
# sudo make install
# if no jpeg support, install libjpeg62 (sudo apt-get install libjpeg62) and possibly libjpeg62-dev

echo '--------------------------------------------'
echo 'Installing Postgres...'
echo '--------------------------------------------'
sudo apt-get install postgres -y
sudo apt-get install libpq-dev -y
sudo apt-get install postgresql-contrib -y

#first setup password to Ubuntu postgres user
sudo echo "postgres:teresa" | sudo chpasswd
#update postgres postgres user
sudo -u postgres psql -U postgres -d postgres -c "alter user postgres with password 'teresa';"
sudo -u postgres createuser vagrant
#restart postgres to ensure extensions are installed
sudo /etc/init.d/postgresql restart

#create user, db, tables, etc
sudo -u postgres psql < /vagrant/create_db.sql

echo '--------------------------------------------'
echo 'Removing unnecessary modules...'
echo '--------------------------------------------'
sudo apt-get -y -f autoremove

cd /vagrant
sudo -H -u vagrant bash -i -c 'bundle install'
mkdir -p shared/pids shared/sockets shared/log

# echo '--------------------------------------------'
# echo 'Getting puma manager config files...'
# echo '--------------------------------------------'
# cd ~
# wget https://raw.githubusercontent.com/puma/puma/master/tools/jungle/upstart/puma-manager.conf
# wget https://raw.githubusercontent.com/puma/puma/master/tools/jungle/upstart/puma.conf

sed -i.bak 's/#force_color_prompt=yes/force_color_prompt=yes/g' ~/.bashrc

echo 'Finished!'
