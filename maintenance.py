from email.MIMEMultipart import MIMEMultipart
from email.MIMEText import MIMEText
import smtplib


import time
import datetime

from sqlalchemy import create_engine, Column, Integer, String, DateTime, Binary
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import exists
from sqlalchemy.orm import sessionmaker
from sqlalchemy.orm.util import has_identity
from sqlalchemy import exc
from sqlalchemy import text


engine = create_engine('mysql://chris:CattleTrax11!@149.149.150.136:3306/cattletrax', echo=False)
Base = declarative_base(engine)
Session = sessionmaker(bind=engine, autoflush=True, autocommit=False)

class Feeder(Base):
	__tablename__='feeder'
	ref_id = Column(Integer, primary_key=True)
	num_visits = Column(Integer)
	last_visit_date = Column("last_visit_date", DateTime)
	
class Cow(Base):
	__tablename__='cow'
	cow_id = Column(Integer, primary_key=True)
	due_date = Column(DateTime)
	first_year = Column(Binary)
	pregnant = Column(Binary)
	calving_cond = Column(String)
	calving_ease = Column(Integer)
	calf_bonding = Column(Integer)
	
class Animal(Base):
	__tablename__='animal'
	animal_id = Column(Integer,primary_key=True)
	tag_id = Column(Integer)
	herd_id = Column(Integer)
	pasture_id = Column(Integer)
	farm_id = Column(Integer)
	a_type = Column(String)

class t1(Base):
	__tablename__='t1'
	cow_id = Column(Integer,primary_key=True)
	tag_id = Column(Integer)
	due_date = Column(DateTime)
	future = Column(DateTime)

class t2(Base):
	__tablename__ = 't2'
	cow_id = Column(Integer,primary_key=True)
	tag_id = Column(Integer)
	due_date = Column(DateTime)
	
def dailyEmail():
	fmt='%H:%M:%S %m-%d-%Y '
	feed = []
	preg = []
	past_due = []
	session = Session()
	#conn = engine.connect()
	stmt = text("SELECT                                      \
  animal.tag_id,                                             \
  feeder.last_visit_date                                     \
FROM                                                         \
  feeder                                                     \
JOIN                                                         \
  animal ON feeder.ref_id = animal.tag_id                 \
WHERE                                                        \
  feeder.last_visit_date <= DATE_ADD(DATE(NOW()),            \
  INTERVAL -3 DAY)")
	stmt = stmt.columns(Animal.tag_id, Feeder.last_visit_date)
	for Animal.tag_id, Feeder.last_visit_date in session.query(Animal.tag_id, Feeder.last_visit_date).from_statement(stmt):
		next = "Tag: "
		id = str(Animal.tag_id)
		next += id
		
		next += "   Last Visit: "
		next += str((Feeder.last_visit_date).strftime(fmt))
		date = Feeder.last_visit_date
		feed.append(next)
	print("Cattle that have not visited the feeder in the past 3 days:")
	for row in feed:
		print(row)
	
	fmt='%m-%d-%Y'
	stmt1 = text("SELECT                                                                   \
  `tag_id`,                                                                                \
  `due_date`                                                                               \
FROM                                                                                       \
(SELECT                                                                                    \
  `cow_id`,                                                                                \
  `tag_id`,                                                                                \
  `due_date`,                                                                              \
  DATE_ADD(DATE(NOW()),                                                                    \
  INTERVAL 7 DAY) AS 'future'                                                              \
FROM                                                                                       \
  `cow`                                                                                    \
JOIN                                                                                       \
  `animal` ON cow.cow_id = animal.animal_id                                                \
WHERE                                                                                      \
  `due_date` >= DATE(NOW()) AND `due_date` <= 'future' AND `pregnant` IS NOT NULL)         \
  AS t1")
	
	stmt1 = stmt1.columns(t1.tag_id, t1.due_date)
	for t1.tag_id, t1.due_date in session.query(t1.tag_id, t1.due_date).from_statement(stmt1):
		next = "Tag: "
		id = str(t1.tag_id)
		next += id
		next += "   Due Date: "
		next += str((t1.due_date).strftime(fmt))
		preg.append(next)
	print("\nCows due in the next 7 days: ")
	for row in preg:
		print(row)
		
	stmt2 = text("SELECT                                                  \
  `tag_id`,                                                               \
  `due_date`                                                             \
FROM                                                                      \
  `cow`                                                                   \
JOIN                                                                      \
  `animal` ON cow.cow_id = animal.animal_id                               \
WHERE                                                                     \
  `due_date` <= DATE(NOW()) AND `pregnant` IS NOT NULL")
	stmt2 = stmt2.columns(t2.tag_id, t2.due_date)
	for t2.tag_id, t2.due_date in session.query(t2.tag_id, t2.due_date).from_statement(stmt2):
		next = "Tag: "
		id = str(t2.tag_id)
		next += id
		next += "   Due Date: "
		next += str((t2.due_date).strftime(fmt))
		past_due.append(next)
	print("\nCows past due: ")
	for row in past_due:
		print row
	

def main():
	
	dailyEmail()
	
if __name__ == "__main__":
	main()