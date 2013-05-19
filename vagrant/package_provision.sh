echo "this shell script is going to setup a running ckan instance based on the CKAN 2.0 packages"

echo "switching the OS language"
locale-gen
export LC_ALL="en_US.UTF-8"
sudo locale-gen en_US.UTF-8

echo "updating the package manager"
sudo apt-get update

echo "installing dependencies available via apt-get"
sudo apt-get install -y nginx apache2 libapache2-mod-wsgi libpq5

echo "downloading the CKAN package"
wget -q http://packaging.ckan.org/python-ckan-2.0_amd64.deb

echo "installing the CKAN package"
sudo dpkg -i python-ckan-2.0_amd64.deb

echo "install postgresql and jetty"
sudo apt-get install -y postgresql solr-jetty openjdk-6-jdk

echo "copying jetty configuration"
cp /vagrant/vagrant/jetty /etc/default/jetty
sudo service jetty start

echo "linking the solr schema file"
sudo mv /etc/solr/conf/schema.xml /etc/solr/conf/schema.xml.bak
sudo ln -s /usr/lib/ckan/default/src/ckan/ckan/config/solr/schema-2.0.xml /etc/solr/conf/schema.xml
sudo service jetty restart

echo "create a CKAN database in postgresql"
sudo -u postgres createuser -S -D -R ckan_default
sudo -u postgres psql -c "ALTER USER ckan_default with password 'pass'"
sudo -u postgres createdb -O ckan_default ckan_default -E utf-8

echo "enabling filestore with local storage"
sudo mkdir -p /var/lib/ckan/default
cp /vagrant/vagrant/package_production.ini /etc/ckan/default/production.ini
sudo chown www-data /var/lib/ckan/default
sudo chmod u+rwx /var/lib/ckan/default
sudo service apache2 restart

echo "creating an admin user"
source /usr/lib/ckan/default/bin/activate
cd /usr/lib/ckan/default/src/ckan
paster sysadmin add admin -c /etc/ckan/default/production.ini

echo "loading some multilingual test data"
paster --plugin=ckan create-test-data translations

echo "you should now have a running instance on http://ckan.lo"
