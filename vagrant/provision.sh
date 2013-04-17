echo "this shell script is going to setup a running ckan instance"

echo "switching the OS language"
locale-gen
export LC_ALL="en_US.UTF-8"
sudo locale-gen en_US.UTF-8

echo "updating the package manager"
sudo apt-get update

echo "installing dependencies available via apt-get"
sudo apt-get install python-dev postgresql libpq-dev python-pip python-virtualenv git-core solr-jetty openjdk-6-jdk vim -y

echo "installing the dependencies available via pip"
virtualenv --no-site-packages /root/pyenv
source /root/pyenv/bin/activate
pip install -e 'git+https://github.com/okfn/ckan.git#egg=ckan'
pip install -r /root/pyenv/src/ckan/pip-requirements.txt

echo "creating a postgres user and database"
sudo -u postgres createuser --superuser $USER # create a default user
psql postgres -c "create role ckanuser login password 'pass'" 
sudo -u postgres createdb -O ckanuser ckantest -E utf-8

echo "copying configuration files"
cd /root/pyenv/src/ckan
cp /vagrant/vagrant/development.ini development.ini
cp /vagrant/vagrant/jetty /etc/default/jetty
sudo mv /etc/solr/conf/schema.xml /etc/solr/conf/schema.xml.bak
cp /root/pyenv/src/ckan/ckan/config/solr/schema-2.0.xml /home/vagrant/schema.xml
sudo ln -s /home/vagrant/schema.xml /etc/solr/conf/schema.xml

echo "restarting jetty for the new configuration to kick-in"
sudo service jetty restart

echo "initialize the database for ckan"
paster --plugin=ckan db init

echo "create folder necessary for ckan to operate"
mkdir data sstore

echo "start the ckan application"
start-stop-daemon --start -b -d /root/pyenv/src/ckan -x /root/pyenv/bin/paster -- serve development.ini

echo ""
echo "you should now have a running ckan instance on http://ckan.lo:5000. Go give it a try!"
echo ""
echo "in case you'd like to load a test dataset"
echo ""
echo "vagrant ssh"
echo "sudo su"
echo "source pyenv/bin/activate"
echo "cd pyenv/src/ckan"
echo "paster --plugin=ckan user add admin"
echo "paster --plugin=ckan sysadmin add admin"
echo "paster --plugin=ckan create-test-data translations"
