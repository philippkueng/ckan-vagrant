echo "this shell script is going to setup a running ckan instance"

echo "switching the OS language"
locale-gen
export LC_ALL="en_US.UTF-8"
sudo locale-gen en_US.UTF-8

echo "updating the package manager"
sudo apt-get update

echo "installing dependencies available via apt-get"
sudo apt-get install python-dev postgresql libpq-dev python-pip python-virtualenv git-core solr-jetty openjdk-6-jdk python-pastescript apache2 libapache2-mod-wsgi vim -y

cp /vagrant/vagrant/ckan.conf /etc/apache2/conf.d/ckan.conf
sudo service apache2 restart

echo "installing the dependencies available via pip"
mkdir -p /usr/local/ckan.lo/
sudo chmod -R a+rX /usr/local/ckan.lo
cd /usr/local/ckan.lo/
virtualenv --no-site-packages /usr/local/ckan.lo/pyenv
source /usr/local/ckan.lo/pyenv/bin/activate
pip install -e 'git+https://github.com/okfn/ckan.git@release-v2.2#egg=ckan'
pip install -r /usr/local/ckan.lo/pyenv/src/ckan/pip-requirements.txt
pip install Pylons
deactivate
source /usr/local/ckan.lo/pyenv/bin/activate

echo "creating a postgres user and database"
sudo -u postgres createuser --superuser $USER # create a default user
psql postgres -c "create role ckanuser login password 'pass'" 
sudo -u postgres createdb -O ckanuser ckantest -E utf-8

echo "copying configuration files"
cd /usr/local/ckan.lo/pyenv/src/ckan
cp /vagrant/vagrant/development.ini development.ini
deactivate
mkdir -p /var/log/solr
cp /vagrant/vagrant/jetty /etc/default/jetty
sudo service jetty restart

sudo mv /etc/solr/conf/schema.xml /etc/solr/conf/schema.xml.bak
sudo ln -s /usr/local/ckan.lo/pyenv/src/ckan/ckan/config/solr/schema-2.0.xml /etc/solr/conf/schema.xml

echo "restarting jetty for the new configuration to kick-in"
sudo service jetty restart

echo "creating logging folder"
sudo chgrp -R www-data data sstore
sudo mkdir -p /var/log/ckan/ckan.lo/
sudo chmod g+w -R /var/log/ckan/ckan.lo/
sudo chown www-data -R /var/log/ckan/ckan.lo/

echo "initialize the database for ckan"
source /usr/local/ckan.lo/pyenv/bin/activate
paster --plugin=ckan db init
touch /var/log/ckan/ckan.lo/
sudo chown www-data /var/log/ckan/ckan.lo/ckan.log

echo "copying wsgi file"
cd /usr/local/ckan.lo/pyenv/bin
cp /vagrant/vagrant/mothership.py mothership.py

echo "enable site in apache"
cd /etc/apache2/sites-available
cp /vagrant/vagrant/ckan.lo ckan.lo

echo "create necessary directories"
cd /usr/local/ckan.lo/pyenv/src/ckan/
mkdir data sstore filestorage
chmod g+w -R data sstore filestorage
sudo chgrp -R www-data data sstore filestorage

echo "launching the site"
sudo a2dissite default
sudo a2ensite ckan.lo
sudo service apache2 restart

echo "creating admin user"
cd /usr/local/ckan.lo/pyenv/src/ckan
paster --plugin=ckan user add admin email=admin@email.org password=pass
paster --plugin=ckan sysadmin add admin

echo "loading test data"
paster --plugin=ckan create-test-data translations

echo "you should now have a running instance on http://ckan.lo"
