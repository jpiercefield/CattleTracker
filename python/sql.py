
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
		truth = session.query(exists().where(Feeder.ref_id == tag)).scalar()
		print(truth)
		if truth is False:
			q = Feeder(ref_id = tag, num_visits = 1, last_visit_date = datetime.datetime.now())
			session.add(q)
			session.commit()
		else:
		 	session.query(Feeder).filter(Feeder.ref_id == tag).\
		 	update({Feeder.num_visits: Feeder.num_visits + 1, Feeder.last_visit_date: datetime.datetime.now()})
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
	ref = 111222
	try:
		updateTable(visits, ref)
	except exc.SQLAlchemyError as e: 
		print(exc.getmessage())

if __name__ == '__main__': main()


	