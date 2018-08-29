--(a)	Create a list of aircraft types that can land in the airport at 
-- Washington Dulles International Airport (Airport_code is 'IAD').

SELECT AIRPLANE_TYPE.Airplane_type_name
FROM AIRPORT INNER JOIN CAN_LAND ON CAN_LAND.Airport_code = AIRPORT.Airport_code 
	INNER JOIN AIRPLANE_TYPE ON AIRPLANE_TYPE.Airplane_type_name = CAN_LAND.Airplane_type_name
WHERE AIRPORT.Airport_code = 'IAD';

--(b)	List all fare information for flight 'United 189'.

SELECT FARE.* , FLIGHT.Airline
FROM FARE INNER JOIN FLIGHT on FARE.Flight_number=FLIGHT.Flight_number 
WHERE FLIGHT.Airline='United 189';


--(c)	Create a list of direct flights (including scheduled departure time and arrival time) starting from 
-- Baltimore Washington International Airport (Airport_code is 'BWI') 
-- and terminating at San Francisco International Airport (Airport_code is 'SFO') 
--which have more than two seats available on 8/15/2018.  

SELECT FLIGHT_LEG.Flight_number, FLIGHT_LEG.Scheduled_departure_time, FLIGHT_LEG.Scheduled_arrival_time 
FROM FLIGHT_LEG, LEG_INSTANCE
WHERE LEG_INSTANCE.ARRIVAL_airport_code='SFO' 
	AND LEG_INSTANCE.Departure_airport_code = 'BWI' 
	AND LEG_INSTANCE.LegDate = '2018-08-15' 
	AND LEG_INSTANCE.Number_of_available_seats > 2
	AND FLIGHT_LEG.Flight_number = LEG_INSTANCE.Flight_number
	AND FLIGHT_LEG.Leg_number = LEG_INSTANCE.Leg_number;

-- In addition, create a list of direct returning flights from 'SFO' to 'BWI' on 8/22/2018.
SELECT FLIGHT_LEG.Flight_number, FLIGHT_LEG.Scheduled_departure_time, FLIGHT_LEG.Scheduled_arrival_time
FROM FLIGHT_LEG, LEG_INSTANCE
WHERE LEG_INSTANCE.Departure_airport_code='SFO' 
	AND LEG_INSTANCE.ARRIVAL_airport_code='BWI' 
	AND LEG_INSTANCE.LegDate = '2018-08-22'
	AND FLIGHT_LEG.Flight_number = LEG_INSTANCE.Flight_number
	AND FLIGHT_LEG.Leg_number = LEG_INSTANCE.Leg_number;
