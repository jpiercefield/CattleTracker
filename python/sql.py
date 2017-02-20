
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy import exists
from sqlalchemy.orm.util import has_identity
from sqlalchemy import exc
import sys


engine = create_engine('mysql://root:Cattle@localhost/cattletrax')
Base = declarative_base(engine)


class feeder(Base):
	__tablename__ = 'feeder'
	__table_args__ = {'autoload':True}

def loadSession():
	metadata = Base.metadata
	Session = sessionmaker(bind=engine)
	session = Session()
	return session

	
	session = loadSession()
	q = session.query(feeder).filter(feeder.ref_id==111111)
	if session.query(q.exists()).scalar():
		print("it exists")

	