-- Haosheng Zhang, Kaizhong Zhang
-- haosheng.zhang@vanderbilt.edu kaizhong.zhang@vanderbilt.edu
-- final project

DROP DATABASE IF EXISTS airlinedelays;
CREATE DATABASE airlinedelays;
USE airlinedelays;
SET SQL_SAFE_UPDATES = 0;
set sql_mode='no_auto_create_user,no_engine_substitution';

DROP TABLE IF EXISTS airlines;
CREATE TABLE airlines(
	iata_code VARCHAR(3),
    airline VARCHAR(500),
	PRIMARY KEY(iata_code)
);
DROP TABLE IF EXISTS airports;
CREATE TABLE airports(
	iata_code VARCHAR(4),
    airport VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    country VARCHAR(255),
    latitude VARCHAR(255),
    longitude VARCHAR(255),
	PRIMARY KEY(iata_code)
);
DROP TABLE IF EXISTS flights;
CREATE TABLE flights(
	year INT,
    month INT,
    day INT,
    day_of_week INT,
    airline VARCHAR(3),
    flight_number INT,
    tail_number VARCHAR(55),
    origin_airport VARCHAR(4),
    destination_airport VARCHAR(4),
    scheduled_departure INT,
    departure_time INT,
    departure_delay INT,
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
    arrival_delay INT,
    diverted INT,
    cancelled INT,
    cancellation_reason TEXT,
    air_system_delay INT,
    security_delay INT,
    airline_delay INT,
    late_aircraft_delay INT,
    weather_delay INT,
    status TEXT,
    flight_id INT AUTO_INCREMENT PRIMARY KEY
);
DROP TRIGGER IF EXISTS insertStatus;
DELIMITER //

CREATE TRIGGER insertStatus
BEFORE INSERT
ON flights
FOR EACH ROW

IF NEW.cancelled!=0 THEN
	SET NEW.status = 'cancelled';
ELSEIF NEW.diverted!=0 THEN 
	SET NEW.status = 'diverted';
ELSEIF NEW.arrival_delay>0 THEN
	SET NEW.status='delayed';
ELSE 
	SET NEW.status='on time';
END IF;
 //

DELIMITER ;

LOAD DATA INFILE 'D:/wamp64/tmp/airlines.csv'
INTO TABLE airlines
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS; 

LOAD DATA INFILE 'D:/wamp64/tmp/airports.csv'
INTO TABLE airports
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

LOAD DATA INFILE 'D:/wamp64/tmp/flights.csv'
INTO TABLE flights
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS; 

INSERT INTO flights(flight_id)
VALUES(DEFAULT)


