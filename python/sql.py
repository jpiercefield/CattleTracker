#!/usr/bin/env python

import time
import bitarray as bt
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
                session.rollback() 
                raise
        finally:
                session.close()
        
log_path = "/home/pi/CattleTrax/log.txt"
log2_path = "/home/pi/CattleTrax/log2.txt"
fmt='%Y-%m-%d %H:%M:%S'
fails = []
ifFails = False
connected = False
error_logged = False



while not connected:
        try:
                
                ser = Serial(port='/dev/ttyUSB0', baudrate=9600, parity=PARITY_NONE, stopbits=STOPBITS_ONE, bytesize=EIGHTBITS, timeout=2, xonxoff=False, rtscts=False)
                connected = True
                continue
        except Exception, e:
                if not error_logged:
                        f = open(log_path, "a")
                        f.write("%s %s\n" % (str(datetime.datetime.now().strftime(fmt)), str(e)))
                        f.close
                        error_logged = True
        time.sleep(5)

while 1:
        try:
                for fail in fails:
                        updateDB(fail)
                        f = open(log_path, "a")
                        f.write("%s %s\n" % (str(datetime.datetime.now().strftime(fmt)), str(fail)))
                        ifFails = True
                        f.close()
                if ifFails:
                        del fails[:]
                        ifFails = False
        except Exception, e:
                continue

        if(ser.inWaiting() > 0):

                x = ser.readline()
                print(x)

                try:
                        updateDB(int(x.replace(" ", "")))
                        f = open(log_path, "a")
                        f.write("%s %s" % (str(datetime.datetime.now().strftime(fmt)), str(x.replace(" ", ""))))
                        f.close()
                except Exception, e:
                        fails.append(int(x.replace(" ", "")))
                        print(fails)
                        print(str(e))
                        f = open(log_path, "a")
                        f.write("%s %s %s\n" % (str(datetime.datetime.now().strftime(fmt)), str(x.replace(" ", "")), str(e)))
                        f.close()

                finally:
                        ser.flush()

 
