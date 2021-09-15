-- Haosheng Zhang, Kaizhong Zhang
-- haosheng.zhang@vanderbilt.edu kaizhong.zhang@vanderbilt.edu
-- final project


DROP TABLE IF EXISTS flight_main;
CREATE TABLE flight_main(
	flight_id INT AUTO_INCREMENT,
	date DATE,
    day_of_week INT,
    airline VARCHAR(3),
    flight_number INT,
    tail_number VARCHAR(10),
    origin_airport VARCHAR(4),
    destination_airport VARCHAR(4),
    scheduled_departure TIME,
    departure_time TIME,
    departure_delay INT,
    taxi_out INT,
    wheels_off TIME,
    scheduled_time INT,
    elapsed_time INT,
    air_time INT,
    distance INT,
    wheels_on TIME,
    taxi_in INT,
    scheduled_arrival TIME,
    arrival_time TIME,
    arrival_delay INT,
    cancellation_reason TEXT,
    air_system_delay INT,
    security_delay INT,
    airline_delay INT,
    late_aircraft_delay INT,
    weather_delay INT,
    status TEXT,
    PRIMARY KEY(flight_id)
);



INSERT INTO flight_main 
SELECT flight_id,(year*10000+month*100+day), day_of_week, airline,flight_number,tail_number,origin_airport,destination_airport,scheduled_departure*100,departure_time*100, departure_delay,taxi_out,wheels_off*100, scheduled_time,elapsed_time,air_time,distance,wheels_on*100,
 taxi_in,scheduled_arrival*100,arrival_time*100,arrival_delay,cancellation_reason,air_system_delay,security_delay,airline_delay,late_aircraft_delay,weather_delay,status
FROM flights 
WHERE flight_id IS NOT NULL;
USE airlinedelays;
DROP TABLE IF EXISTS flight_diverted;
CREATE TABLE IF NOT EXISTS flight_diverted(
	flight_id INT,
    date DATE,
    day_of_week INT,
    airline VARCHAR(3),
    flight_number INT,
    tail_number VARCHAR(64),
    origin_airport VARCHAR(4),
    destination_airport VARCHAR(4),
    scheduled_departure TIME,
    departure_time TIME,
    departure_delay INT,
    scheduled_time INT,
    distance INT,
    scheduled_arrival TIME,
    arrival_time TIME,
    status TEXT,
		PRIMARY KEY(date,airline,flight_number,origin_airport,destination_airport,scheduled_departure)
);
INSERT INTO flight_diverted
	SELECT  flight_id,date,day_of_week,airline,flight_number,tail_number,origin_airport,destination_airport,scheduled_departure,departure_time,departure_delay,scheduled_time,distance, scheduled_arrival,arrival_time,status
	FROM flight_main
	WHERE status='diverted'  AND date is not null;
	
	
DROP TABLE IF EXISTS flight_cancelled;
CREATE TABLE IF NOT EXISTS flight_cancelled(
	flight_id INT,
	date DATE,
    day_of_week INT,
    airline VARCHAR(3),
    flight_number INT,
    tail_number VARCHAR(64),
    origin_airport VARCHAR(4),
    destination_airport VARCHAR(4),
    scheduled_departure TIME,
    scheduled_time INT,
    distance INT,
    scheduled_arrival TIME,
	cancellation_reason TEXT,
    status TEXT,
		PRIMARY KEY(date,airline,flight_number,origin_airport,destination_airport,scheduled_departure)
);

INSERT INTO flight_cancelled
	SELECT  flight_id,date,day_of_week,airline,flight_number,tail_number,origin_airport,destination_airport,scheduled_departure,scheduled_time,distance, scheduled_arrival, cancellation_reason, status
	FROM flight_main
	WHERE status='cancelled'  AND date is not null;

DROP TABLE IF EXISTS flight_delayed;
CREATE TABLE flight_delayed(
	flight_id INT,
	date DATE,
    day_of_week INT,
    airline VARCHAR(3),
    flight_number INT,
    tail_number VARCHAR(64),
    origin_airport VARCHAR(4),
    destination_airport VARCHAR(4),
    scheduled_departure TIME,
    departure_time TIME,
    departure_delay INT,
    taxi_out INT,
    wheels_off TIME,
    scheduled_time INT,
    elapsed_time INT,
    air_time INT,
    distance INT,
    wheels_on TIME,
    taxi_in INT,
    scheduled_arrival TIME,
    arrival_time TIME,
    arrival_delay INT,
    air_system_delay INT,
    security_delay INT,
    airline_delay INT,
    late_aircraft_delay INT,
    weather_delay INT,
    status TEXT,
		PRIMARY KEY(date,airline,flight_number,origin_airport,destination_airport,scheduled_departure)
);

INSERT INTO flight_delayed
	SELECT  flight_id,date,day_of_week,airline,flight_number,tail_number,origin_airport,destination_airport,scheduled_departure,departure_time,departure_delay,
    taxi_out,wheels_off,scheduled_time,elapsed_time,air_time,distance,wheels_on,taxi_in, scheduled_arrival, arrival_time,arrival_delay,air_system_delay,security_delay,airline_delay,late_aircraft_delay,weather_delay,status
	FROM flight_main
	WHERE status='delayed'  AND date is not null;
    
DROP TABLE IF EXISTS flight_ontime;
CREATE TABLE flight_ontime(
	flight_id INT,
	date DATE,
    day_of_week INT,
    airline VARCHAR(3),
    flight_number INT,
    tail_number VARCHAR(64),
    origin_airport VARCHAR(4),
    destination_airport VARCHAR(4),
    scheduled_departure INT,
    departure_time INT,
    taxi_out INT,
    wheels_off INT,
    scheduled_time INT,
    elapsed_time INT,
    air_time INT,
    distance INT,
    wheels_on INT,
    taxi_in INT,
    scheduled_arrival INT,
    arrival_time INT,
    status TEXT,
		PRIMARY KEY(date,airline,flight_number,origin_airport,destination_airport,scheduled_departure)
);

INSERT INTO flight_ontime
	SELECT  flight_id,date,day_of_week,airline,flight_number,tail_number,origin_airport,destination_airport,scheduled_departure,departure_time,taxi_out,wheels_off,scheduled_time,elapsed_time,air_time,distance,wheels_on,taxi_in, scheduled_arrival, arrival_time,status
	FROM flight_main
	WHERE status='on time' AND date is not null;


