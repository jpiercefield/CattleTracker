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


engine = create_engine('mysql://root:CattleTrax11!@localhost:3306/cattletrax', echo=False)
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
	num = Column(Integer)
	future = Column(DateTime)

class t2(Base):
	__tablename__ = 't2'
	cow_id = Column(Integer,primary_key=True)
	tag_id = Column(Integer)
	due_date = Column(DateTime)
	past = Column(Integer)

class t3(Base):
	__tablename__ = 't3'
	cow_id = Column(Integer,primary_key=True)
	tag_id = Column(Integer)
	due_date = Column(DateTime)
	past = Column(Integer)

class user(Base):
	__tablename__ = 'user'
	user_id = Column(Integer, primary_key=True)
	email = Column(String)

def createBody():
	fmt='%H:%M:%S %m-%d-%Y '
	feed = []
	today = []
	preg = []
	past_due = []
	body = ""
	session = Session()
	#conn = engine.connect()
	stmt = text("SELECT                                      \
  animal.tag_id,                                             \
  feeder.last_visit_date                                     \
FROM                                                         \
  feeder                                                     \
JOIN                                                         \
  animal ON feeder.ref_id = animal.rfid                 \
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
	body += "\nCattle that have not visited the feeder in the past 3 days:"
	if not feed:
		body += "\nNothing!"
	else:
		for row in feed:
			body += "\n"
			body += row




	stmt3 = text("SELECT                                                  \
  `tag_id`,                                                               \
  `due_date`,															  \
  DATEDIFF(DATE(NOW()), `due_date`) AS 'past'							  \
FROM                                                                      \
  `cow`                                                                   \
JOIN                                                                      \
  `animal` ON cow.cow_id = animal.animal_id                               \
WHERE                                                                     \
  `due_date` = DATE(NOW()) AND `pregnant` = 1					  \
ORDER BY																  \
  `past` DESC")
	stmt3 = stmt3.columns(t3.tag_id, t3.due_date, t3.past)
	for t3.tag_id, t3.due_date, t3.past in session.query(t3.tag_id, t3.due_date, t3.past).from_statement(stmt3):
		next = "Tag: "
		id = str(t3.tag_id)
		next += id
		today.append(next)

	body += "\n\nCows due today: "
	if not today:
		body += "\nNothing!"
	else:
		for row in today:
			body += "\n"
			body += row

	fmt='%m-%d-%Y'
	stmt1 = text("SELECT                                                                   \
  `tag_id`,                                                                                \
  `due_date`,                                                                              \
  `num`\
FROM                                                                                       \
(SELECT                                                                                    \
  `cow_id`,                                                                                \
  `tag_id`,                                                                                \
  `due_date`,                                                                              \
  DATEDIFF(`due_date`,DATE(NOW())) AS 'num'                                                              \
FROM                                                                                       \
  `cow`                                                                                    \
JOIN                                                                                       \
  `animal` ON cow.cow_id = animal.animal_id                                                \
WHERE                                                                                      \
  `due_date` > DATE(NOW()) AND `due_date` <= (DATE(NOW())+7) AND `pregnant` = 1)         \
  AS t1																					   \
ORDER BY																				   \
  `num` ASC")
	stmt1 = stmt1.columns(t1.tag_id, t1.due_date, t1.num)
	for t1.tag_id, t1.due_date, t1.num in session.query(t1.tag_id, t1.due_date, t1.num).from_statement(stmt1):
		next = "Tag: "
		id = str(t1.tag_id)
		next += id
		next += "   Days until Due: "
		next += str(t1.num)
		next += "   Due Date: "
		next += str((t1.due_date).strftime(fmt))
		preg.append(next)
	body += "\n\nCows due in the next 7 days: "
	if not preg:
		body += "\nNothing!"
	else:
		for row in preg:
			body += "\n"
			body += row

	stmt2 = text("SELECT                                                  \
  `tag_id`,                                                               \
  `due_date`,															  \
  DATEDIFF(DATE(NOW()), `due_date`) AS 'past'							  \
FROM                                                                      \
  `cow`                                                                   \
JOIN                                                                      \
  `animal` ON cow.cow_id = animal.animal_id                               \
WHERE                                                                     \
  `due_date` < DATE(NOW()) AND `pregnant` = 1					  \
ORDER BY																  \
  `past` DESC")
	stmt2 = stmt2.columns(t2.tag_id, t2.due_date, t2.past)
	for t2.tag_id, t2.due_date, t2.past in session.query(t2.tag_id, t2.due_date, t2.past).from_statement(stmt2):
		next = "Tag: "
		id = str(t2.tag_id)
		next += id
		next += "   Days Past Due: "
		next += str(t2.past)
		next += "   Due Date: "
		next += str((t2.due_date).strftime(fmt))
		past_due.append(next)

	body += "\n\nCows past due: "
	if not past_due:
		body += "\nNothing!"
	else:
		for row in past_due:
			body += "\n"
			body += row

	return body


def sendEmail(bod):
	fromaddr = "cattletrackernotifications@gmail.com"
	session = Session()
	for email in session.query(user.email, user.user_id).filter(user.user_id == 1):
		toaddr = str(email.email)
	msg = MIMEMultipart()
	msg['From'] = fromaddr
	msg['To'] = toaddr
	msg['Subject'] = "Daily Email"

	body = bod
	msg.attach(MIMEText(body, 'plain'))

	server = smtplib.SMTP('smtp.gmail.com', 587)
	server.ehlo()
	server.starttls()
	server.ehlo()
	server.login("Cattletrackernotifications", "Tracker2017")
	text = msg.as_string()
	server.sendmail(fromaddr, toaddr, text)


def main():

	body = createBody()
	sendEmail(body)


if __name__ == "__main__":
	main()
