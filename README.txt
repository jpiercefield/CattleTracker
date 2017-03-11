Installation Notes

OS:  linux (ubuntu server)
Apache2 web server
MySql
PHP

https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-16-04

Python:
Sqlalchemy:
sudo apt-get install mysql-server
sudo apt-get install mysql-client
sudo apt-get install libmysqlclient15-dev
Second step,install the python-mysqldb:

sudo apt-get install python-mysqldb
Third step,install the easy_install:

sudo wget http://peak.telecommunity.com/dist/ez_setup.py
sudo python ez_setup.py
Forth step,install the MySQL-Python:

sudo easy_install MySQL-Python
Finally,sqlalchemy:

sudo easy_install SQLAlchemy

PySerial:
download tarball from https://pypi.python.org/pypi/pyserial
untar and run:
sudo python setup.py install