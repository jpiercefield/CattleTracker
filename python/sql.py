#!/usr/bin/env python

import time
from serial import Serial, SEVENBITS, EIGHTBITS, STOPBITS_ONE, PARITY_NONE
import io
from sqlalchemy import create_engine, Column, Integer, String, DateTime
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import exists
from sqlalchemy.orm import sessionmaker
from sqlalchemy.orm.util import has_identity
from sqlalchemy import exc
import sys
import datetime

engine = create_engine('mysql://pjtinker:CattleTrax11!@149.149.150.136:3306/cattletrax', echo=True)
Base = declarative_base(engine)
Session = sessionmaker(bind=engine, autoflush=True, autocommit=False)
class Feeder(Base):
        __tablename__='feeder'
        ref_id = Column(Integer, primary_key=True)
        num_visits = Column(Integer)
        last_visit_date = Column("last_visit_date", DateTime)

        
def updateDB(tag_id):
        try:
                session = Session()
                truth = session.query(exists().where(Feeder.ref_id==tag_id)).scalar()
                if truth is False:
                        q = Feeder(ref_id = tag_id, num_visits = 1, last_visit_date = datetime.datetime.now())
                        session.add(q)
                else:
                        session.query(Feeder).filter(Feeder.ref_id==tag_id).\
                        update({Feeder.num_visits: Feeder.num_visits + 1, Feeder.last_visit_date: datetime.datetime.now()})
                        

                session.commit()
        except:
                session.rollback() #do we want to rollback if we are saving queries?
                raise
        finally:
                session.close()
        
def main():
        fmt='%Y-%m-%d %H:%M:%S'
        ser = Serial(port='/dev/ttyUSB0', baudrate=9600, parity=PARITY_NONE, stopbits=STOPBITS_ONE, bytesize=EIGHTBITS, timeout=2, xonxoff=False, rtscts=False)
        fails = []
        while 1:

                if(ser.inWaiting() > 0):

                        x = ser.readline()
                        print(x)
                        f = open("log.txt", "a")
                        f.write("%s %s" % (str(datetime.datetime.now().strftime(fmt)), str(x.replace(" ", ""))))

                        try:
                                updateDB(int(x.replace(" ", "")))
                                for fail in fails:
                                        updateDB(fail)
                                del fails[:]       
                        except Exception, e:
                                fails.append(int(x.replace(" ", "")))
                                print(fails)
                                print(str(e))
                                f.write("%s %s\n" % (str(e), str(datetime.datetime.now().strftime(fmt))))
                        finally:
                                f.close()
                                ser.flush()

if __name__ == '__main__': main()

