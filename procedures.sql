-- Creating procedures for website

SET SQL_SAFE_UPDATES = 0;

-- search by date
DROP PROCEDURE IF EXISTS searchbydate;

DELIMITER //

CREATE PROCEDURE searchbydate(IN month INT, IN day INT)

BEGIN

DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT('No result found!');

SELECT  year,month,day,day_of_week,airline,flight_number, tail_number, 
		origin_airport, destination_airport, scheduled_departure, departure_time,departure_delay, 
        scheduled_time, elapsed_time, istance, scheduled_arrival, arrival_time, arrival_delay,
		diverted, cancelled
FROM flights
WHERE flights.month = month AND flights.day = day;

END //

DELIMITER ;

-- search by airline

DROP PROCEDURE IF EXISTS searchbyairline;

DELIMITER //

CREATE PROCEDURE searchbyairline(IN airline VARCHAR(3))

BEGIN

DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT('No result found!');

SELECT  year,month,day,day_of_week,airline,flight_number, tail_number, 
		origin_airport, destination_airport, scheduled_departure, departure_time,departure_delay, 
        scheduled_time, elapsed_time, istance, scheduled_arrival, arrival_time, arrival_delay,
		diverted, cancelled
FROM flights
WHERE flights.airline = airline;

END //

DELIMITER ;

-- search by tailnumber

DROP PROCEDURE IF EXISTS searchbytailnumber;

DELIMITER //

CREATE PROCEDURE searchbytailnumber(IN tailnumber INT)

BEGIN

DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT('No result found!');

SELECT  year,month,day,day_of_week,airline,flight_number, tail_number, 
		origin_airport, destination_airport, scheduled_departure, departure_time,departure_delay, 
        scheduled_time, elapsed_time, istance, scheduled_arrival, arrival_time, arrival_delay,
		diverted, cancelled
FROM flights
WHERE flights.tailnumber = tail_number;



END //

DELIMITER ;

-- seearch by flight number
DROP PROCEDURE IF EXISTS searchbyflight;

DELIMITER //

CREATE PROCEDURE searchbyflight(IN flight INT)

BEGIN

DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT('No result found!');

SELECT  year,month,day,day_of_week,airline,flight_number, tail_number, 
		origin_airport, destination_airport, scheduled_departure, departure_time,departure_delay, 
        scheduled_time, elapsed_time, istance, scheduled_arrival, arrival_time, arrival_delay,
		diverted, cancelled
FROM flights
WHERE flights.flight_number = flight;

END //

DELIMITER ;


-- seearch by delay type
DROP PROCEDURE IF EXISTS searchbytype;

DELIMITER //

CREATE PROCEDURE searchbytype(IN type VARCHAR(255))

BEGIN

DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT('No result found!');

IF (type = 'cancelled' OR type = 'CANCELLED') THEN 
SELECT  *
FROM flights_cancelled;
ELSEIF (type = 'diverted' OR type = 'DIVERTED') THEN
SELECT  *
FROM flights_diverted;
ELSEIF (type = 'delayed' OR type = 'DELAYED') THEN
SELECT  *
FROM flights_delayed;
ELSE
SELECT('No result found!');
END IF;

END //

DELIMITER ;
DROP PROCEDURE IF EXISTS updatecancellationreason;

-- procedure using transaction for updating cancellation. would update both flight_main and divided table.
DELIMITER //

CREATE PROCEDURE updatecancellationreason(IN reason TEXT, IN u_date DATE, IN u_airline VARCHAR(55), IN u_flight_number INT, IN u_origin_airport VARCHAR(4), IN u_destination_airport VARCHAR(4),IN u_scheduled_departure TIME)
BEGIN
	START TRANSACTION; 
		UPDATE flight_main
		SET cancellation_reason = reason
        WHERE status='cancelled' AND date=u_date AND airline=u_airline AND flight_number = u_flight_number AND origin_airport=u_origin_airport AND destination_airport=u_destination_airport AND scheduled_departure=u_scheduled_departure;
        UPDATE flight_cancelled
		SET cancellation_reason = reason
        WHERE date=u_date AND airline=u_airline AND flight_number = u_flight_number AND origin_airport=u_origin_airport AND destination_airport=u_destination_airport AND scheduled_departure=u_scheduled_departure;
 
		COMMIT;
		SELECT 'UPDATE SUCCESSFUL!';


END //

DELIMITER ;

-- Insert into airport table
DROP PROCEDURE IF EXISTS insertairports;

-- procedure using transaction for inserting airports
DELIMITER //

CREATE PROCEDURE insertairports(iata_code VARCHAR(3), airport VARCHAR(255), city VARCHAR(255),state VARCHAR(255), 
								country VARCHAR(255), latitude VARCHAR(255), longitude VARCHAR(255))
BEGIN    
	START TRANSACTION;
		INSERT INTO airports
        VALUES(iata_code, airport , city,state , 
				country , latitude , longitude);
        
		SELECT'INSERTION SUCCESSFUL'
        COMMIT;
        

END //

DELIMITER ;

-- Insert into airline table
DROP PROCEDURE IF EXISTS insertairlines;

-- procedure using transaction for inserting airlines
DELIMITER //

CREATE PROCEDURE insertairlines(iata_code VARCHAR(3), airline VARCHAR(255))
BEGIN
    
	START TRANSACTION;
		INSERT INTO airlines
        VALUES(iata_code, airline);
        
		COMMIT;
		SELECT 'INSERT SUCCESSFUL!';

END //

DELIMITER ;



-- Get information detailed button is called. Would select from the certain table when a record's detail is required.
DROP PROCEDURE IF EXISTS getByid;

DELIMITER //

CREATE PROCEDURE getByid(IN id INT)

BEGIN
	DECLARE sql_error INT DEFAULT FALSE;
	DECLARE S VARCHAR(64) default null;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION SET sql_error = TRUE;
SET S= (SELECT status FROM flight_main where flight_id=id);
IF S='on time' THEN
	SELECT * FROM flight_ontime
    WHERE flight_id=id;
ELSEIF S='diverted' THEN
	SELECT * FROM flight_diverted
    WHERE flight_id=id;
ELSEIF S='cancelled' THEN
	SELECT * FROM flight_cancelled
    WHERE flight_id=id;
ELSE 
	SELECT * FROM flight_delayed
	WHERE flight_id=id;
END IF;
IF sql_error = FALSE THEN
			COMMIT;
            SELECT 'INSERT SUCCESSFUL!';
		ELSE
			ROLLBACK;
            SELECT 'TANSACTION ROLLED BACK';
		END IF;
END //
DELIMITER ;

-- delete the record from divided table when a record is deleted. Would be automatically called when the megatable is deleted.
DROP TRIGGER IF EXISTS deleteRecord;
DELIMITER //
CREATE TRIGGER deleteRecord
AFTER DELETE
ON flight_main
FOR EACH ROW

	IF OLD.status='on time' THEN
	DELETE FROM flight_ontime
    WHERE flight_id=OLD.flight_id;
	ELSEIF OLD.status='delayed' THEN
	DELETE FROM flight_delayed
    WHERE flight_id=OLD.flight_id;
	ELSEIF OLD.status='diverted' THEN
	DELETE FROM flight_diverted
    WHERE flight_id=OLD.flight_id;
	ELSE
	DELETE FROM flight_cancelled
    WHERE flight_id=OLD.flight_id;
END IF;


//
DELIMITER ;


DROP TRIGGER IF EXISTS nullIataAirline;
DELIMITER //
CREATE TRIGGER nullIataAirline
BEFORE INSERT
ON airlines
FOR EACH ROW

	IF NEW.iata_code IS NULL THEN
		SIGNAL	SQLSTATE'22003'
		SET	MESSAGE_TEXT = 'The primary key cannot be null';
END IF;


//
DELIMITER ;

DROP TRIGGER IF EXISTS nullIataAirport;
DELIMITER //
CREATE TRIGGER nullIataAirport
BEFORE INSERT
ON airports
FOR EACH ROW

	IF NEW.iata_code IS NULL THEN
		SIGNAL	SQLSTATE'22003'
		SET	MESSAGE_TEXT = 'The primary key cannot be null';
END IF;


//
DELIMITER ;

