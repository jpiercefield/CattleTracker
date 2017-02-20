import sqlalchemy
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

engine = create_engine('mysql://root:Cattle@localhost/cattletrax')
Base = declarative_base(engine)

class animal(Base):
	__tablename__ = 'animal'
	__table_args__ = {'autoload':True}

def loadSession():
	metadata = Base.metadata
	Session = sessionmaker(bind=engine)
	session = Session()
	return session


if __name__ == "__main__":
	session = loadSession()
	res = session.query(animal).all()
	print (res[1].title)