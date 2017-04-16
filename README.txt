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
//Third step,install the easy_install:

sudo wget http://peak.telecommunity.com/dist/ez_setup.py
sudo python ez_setup.py
//Forth step,install the MySQL-Python:

sudo easy_install MySQL-Python
//Finally,sqlalchemy:

sudo easy_install SQLAlchemy

PySerial:
download tarball from https://pypi.python.org/pypi/pyserial
untar and run:
sudo python setup.py install

TODO:

Database:
-Add/Delete Cow Procedure
-Update Cow Procedure
-Add vaccination data.  Need to figure out how to actually store/display these.  
-Expand search functionality to include herd and pasture.
-Change  preganant and first year in Cow table to No by default.  
-Add table to vaccines that indicates vaccination due.  
-Add valid column to each table in order to determine what has been "deleted" and what is valid?
-Do we want to archive data?
-When adding calf, setup necessary vaccines w/ dates.
-add DOB and medical condition to vitals
-Search using Tag ID or Animal ID searches both fields, regardless of the text field the user selected.  FIXED
-redo add_bull and add_calf proc, set a_type.
-allow users to create vaccines and set the time interval for administration
-make table to store any deleted animals.  Make the table flat with basic info. 
-set default values for herd, pasture, farm to 0 in animal.  0 = unspecified.  

RPI:
-Learn more about SQL Alchemy's timeouts, connection pooling, etc., to improve functionality
-Format log file.  Should we create our own error messages/codes?
-Pi will lose data if it has lost signal, read tags, then lost power before reconnecting to the DB.  How can we correct this?
-Added pool_recycle=3600 to SQLAlchemy engine.  This will refresh any connection to the DB after one hour.  Check this when testing the Pi.


HTML:
-Make list of animals that visited feeder clickable.  Click calls pop-up that displays vitals.  
-Validate input for all of our user fields.  **Need to validate Sire and Dam animal_id if adding to vitals.  Do this in JS?
-Check out Drop Down Menu/Text field in one on StackOverflow for example on how to do vaccines.

24 Hour Maintenance:  
-Daily report including upcoming vaccination dates for animals, upcoming delivery dates, animals that have not visited the mineral feeder in 3 days.  
-Check ages of calves, reclassifying to cow or bull upon reaching certain date.  
-Check each animal for upcoming vaccinations.  If yes, update the need_vaccination field in vaccines.  Preliminary work done.  Need specifics on vaccine type and timeframe for administration






