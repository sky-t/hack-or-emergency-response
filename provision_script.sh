#!/bin/bash


echo 'Setting up logfile'
LOGFILE=/home/vagrant/provision_script.log
echo > $LOGFILE



# Add postgis to list of trusted repositories
echo 'Adding postgis to list of trusted repositories...'
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt trusty-pgdg main" >> /etc/apt/sources.list'
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -
apt-get update -y
apt-get upgrade -y


# install apt packages

echo 'Installing Firefox...'
apt-get install -y firefox >> $LOGFILE
echo 'Installing PostgreSQL 9.5...'
apt-get install -y postgresql-9.5-postgis-2.2 >> $LOGFILE
echo 'Installing pgadmin3...'
apt-get install -y pgadmin3 >> $LOGFILE
echo 'Installing pgRouting 2.1...'
apt-get install -y postgresql-9.5-pgrouting >> $LOGFILE
echo 'Installing Python for Postgres...'
apt-get install -y postgresql-plpython3-9.5 >> $LOGFILE
echo 'Installing pip...'
apt-get install -y python-pip >> $LOGFILE
echo 'Installing dos2unix...'
apt-get install -y dos2unix >> $LOGFILE
echo 'setting up libpg-dev'
apt-get install -y libpq-dev
echo 'setting up psycopg2'
apt-get install python -y psycopg2
echo 'Cleaning up APT...'
apt-get autoremove - >> $LOGFILE



# install Python packages

echo 'Installing csvkit...'
pip install csvkit >> $LOGFILE         # for commands 'csvsql' and 'csvstat'



# configure PostgreSQL

echo 'Creating vagrant user in PostgreSQL...'
su postgres -c 'psql -c "CREATE USER vagrant WITH CREATEUSER;"' >> $LOGFILE

echo 'Creating vagrant database in PostgreSQL...'
su postgres -c 'psql -c "CREATE DATABASE vagrant;"' >> $LOGFILE

echo 'Loading data into PostgreSQL...'
su vagrant -c 'psql < proj/buildCrimeDataRaw.sql' >> $LOGFILE

echo 'Running scripts as user vagrant...'
su vagrant -c 'bash ~vagrant/proj/provision_script_vagrant.sh' >> $LOGFILE

# change log file owner to vagrant
chown vagrant:vagrant $LOGFILE


echo 'Finished installing packages.'
echo 'Run the following line on your host machine:'
echo '$ vagrant plugin install vagrant-vbguest'