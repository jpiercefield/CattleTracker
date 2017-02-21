
from sqlalchemy import create_engine, Column, Integer, String, DateTime
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy import exists
from sqlalchemy.orm.util import has_identity
from sqlalchemy import exc
import sys
import datetime

engine = create_engine('mysql://root:Cattle@localhost/cattletrax', echo=True)
Base = declarative_base(engine)
Session = sessionmaker(bind=engine)

class Feeder(Base):
	__tablename__ = 'feeder'
	ref_id = Column(Integer, primary_key=True)
	num_visits = Column(Integer)
	last_visit_date = Column(DateTime)

##Let's use the ORM, shall we?
def updateTable(visits, tag):
	try:
		session = Session()
		q = Feeder(ref_id = tag, num_visits = 1, last_visit_date = datetime.datetime.now())
		session.add(q)
		session.commit()
		
	except:
		session.rollback()
		raise
	finally:
		session.close()
###TODO:  Do we keep the tally and sql stuff in one script or separate them?
#		  
def main():
	visits = 2
	ref = 99999
	try:
		updateTable(visits, ref)
	except: 
		print("errors have occured")

if __name__ == '__main__': main()
##Second try.  This time using a connection without the ORM.  
# Base.metadata.create_all(engine)
# try:
# 	connect = engine.connect()
# 	result = connect.execute("select * from animal")
# 	for row in result:
# 	    print("id:", row['animal_id'])
# 	connect.close()
# except exc.OperationalError:
# 	print("Unable to connect to database!")


#####Original Try
# class feeder(Base):
# 	__tablename__ = 'feeder'
# 	__table_args__ = {'autoload':True}

# def loadSession():
# 	metadata = Base.metadata
# 	Session = sessionmaker(bind=engine)
# 	session = Session()
# 	return session

	
# 	session = loadSession()
# 	q = session.query(feeder).filter(feeder.ref_id==1111)
# 	if session.query(q.exists()).scalar():
# 		print("it exists")

	