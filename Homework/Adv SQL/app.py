import numpy as np
from matplotlib import style
style.use('fivethirtyeight')
import matplotlib.pyplot as plt
import pandas as pd
from datetime import datetime
import datetime as dt
import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func, inspect, desc
from flask import Flask, jsonify


#################################################
# Database Setup
#################################################
engine = create_engine("sqlite:///hawaii.sqlite")

# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)

# Save reference to the table
Measurement = Base.classes.measurement
Station = Base.classes.station

#################################################
# Flask Setup
#################################################
app = Flask(__name__)


#################################################
# Flask Routes
#################################################

@app.route("/")
def welcome():
    """List all available api routes."""
    return (
        f"Available Routes:<br/>"
        f"/api/v1.0/precipitation<br/>"
        f"/api/v1.0/stations<br/>"
        f"/api/v1.0/tabs<br/>"
        f"/api/v1.0/start date: (yyyy-mm-dd)<br/>"
        f"/api/v1.0/start date/end date: (yyyy-mm-dd)"
    )


@app.route("/api/v1.0/precipitation")
def precipitation():
    # Create our session (link) from Python to the DB
    session = Session(engine)

    """Return a list of all passenger names"""
    #Determine last date in Measurement
    last_date = session.query(Measurement.date).order_by(Measurement.date.desc()).first()
    year_ago= (dt.datetime.strptime(str(last_date[0]),"%Y-%m-%d"))-dt.timedelta(days=365)
    
    #Design a query to retrieve the last 12 months of precipitation data (using 8/23/2017 as end date)
    sel = [Measurement.date,Measurement.prcp]
    last_twelve = session.query(*sel).filter(Measurement.date > (year_ago)).order_by(Measurement.date).all()
    
    session.close()

    # Convert list of tuples into normal list
    rain = list(np.ravel(last_twelve))

    return jsonify(rain)

@app.route("/api/v1.0/stations")
def stations():
    # Create our session (link) from Python to the DB
    session = Session(engine)

    # Return a list of stations in the dataset
    # Query all measurements

    station_data = session.query(Station.station,Station.name).all()
    # selall = [Measurement.tobs,Measurement.date]
    # station_data = session.query(Measurement.station,             
    # func.count(Measurement.id).label('qty')
    # ).group_by(Measurement.station
    # ).order_by(desc('qty'))

    # Convert list of tuples into normal list
    station_list = list(np.ravel(station_data))

    return jsonify(station_list)

    session.close()

@app.route("/api/v1.0/tobs")
def tobs():
    # Create our session (link) from Python to the DB
    session = Session(engine)

    #query for the dates and temperature observations from a year from the last data point.
    #Return a JSON list of Temperature Observations (tobs) for the previous year.
    
    #Determine last date in Measurement
    last_date = session.query(Measurement.date).order_by(Measurement.date.desc()).first()
    year_ago= (dt.datetime.strptime(str(last_date[0]),"%Y-%m-%d"))-dt.timedelta(days=365)
    
    #Design a query to retrieve the last 12 months of tobs data (using 8/23/2017 as end date)
    seltobs = [Measurement.date,Measurement.tobs]
    last_twelve_tobs = session.query(*seltobs).filter(Measurement.date > (year_ago)).order_by(Measurement.date).all()
    
    # Convert list of tuples into normal list
    tobs_list = list(np.ravel(last_twelve_tobs))

    return jsonify(tobs_list)

    session.close()

#Return a JSON list of the minimum temperature, the average temperature, and the max temperature for a given start or start-end range.
#When given the start only, calculate TMIN, TAVG, and TMAX for all dates greater than and equal to the start date.

@app.route("/api/v1.0/<start>")
def calc_temps_by_start(start):

    # Create our session (link) from Python to the DB
    session = Session(engine)

    output = session.query(func.min(Measurement.tobs), func.avg(Measurement.tobs), func.max(Measurement.tobs)).\
        filter(Measurement.date >= start).all()
    
    start_only = list(np.ravel(output))

    return jsonify(f"For start date = {start}: Tmin = {start_only[0]}, Tavg = {round(start_only[1])}, Tmax = {start_only[2]}")

    # return jsonify(start_only)

    session.close()


# When given the start and the end date, calculate the TMIN, TAVG, and TMAX for dates between the start and end date inclusive.    
@app.route("/api/v1.0/<start>/<end>")
def calc_temps_by_range(start,end):

    # Create our session (link) from Python to the DB
    session = Session(engine)

    output_with_end = session.query(func.min(Measurement.tobs), func.avg(Measurement.tobs), func.max(Measurement.tobs)).\
        filter(Measurement.date >= start).filter(Measurement.date <= end).all()

    output_with_end_list = list(np.ravel(output_with_end))

    return jsonify(f"For start date = {start} and end date = {end}: Tmin = {output_with_end_list[0]}, Tavg = {round(output_with_end_list[1])}, Tmax = {output_with_end_list[2]}")
    
    
    #return output_list

    session.close()

if __name__ == '__main__':
    app.run(debug=True)
