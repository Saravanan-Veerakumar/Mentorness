use mentorness;
SELECT * FROM hotel_reservation LIMIT 10;
/*The hotel industry relies on data to make informed decisions and provide a better guest experience. In this internship,
you will work with a hotel reservation dataset to gain insights into guest preferences, booking trends, and other key
factors that impact the hotel's operations. You will use SQL to query and analyze the data, as well as answer specific
questions about the dataset.*/



#PROBLEM STATEMENT
#1. What is the total number of reservations in the dataset?
SELECT COUNT(Booking_ID) FROM hotel_reservation;
# Result: 700


#2. Which meal plan is the most popular among guests? 
SELECT DISTINCT type_of_meal_plan FROM hotel_reservation;
SELECT COUNT(type_of_meal_plan) FROM hotel_reservation WHERE type_of_meal_plan='Meal Plan 1';
SELECT COUNT(type_of_meal_plan) FROM hotel_reservation WHERE type_of_meal_plan='Meal Plan 2';
SELECT COUNT(type_of_meal_plan) FROM hotel_reservation WHERE type_of_meal_plan='Not Selected';
# Result: "Meal Plan 1"

#3. What is the average price per room for reservations involving children?

SELECT DISTINCT no_of_children FROM hotel_reservation;
SELECT * FROM hotel_reservation WHERE no_of_children>=1;
SELECT AVG(avg_price_per_room) AS Average_price_per_room_for_reservations_involving_children FROM hotel_reservation WHERE no_of_children>=1;
SELECT AVG(avg_price_per_room) AS Average_price_per_room_for_reservations_involving_children FROM hotel_reservation WHERE no_of_children<1;

#4. How many reservations were made for the year 20XX (replace XX with the desired year)?
SELECT * FROM hotel_reservation;
/* Checking the data type of the 'arrival_date' column */
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'hotel_reservation' AND COLUMN_NAME = 'arrival_date';
/*SELECT arrival_date, STR_TO_DATE(arrival_date, '%d-%m-%Y') AS formatted_date FROM hotel_reservation;*/

ALTER TABLE hotel_reservation ADD COLUMN new_arrival_date DATE; /*Adding new column*/
SET SQL_SAFE_UPDATES = 0; /*Toggling the safe mode to OFF*/
UPDATE hotel_reservation SET new_arrival_date=STR_TO_DATE(arrival_date,'%d-%m-%Y'); /* COPYING THE FORMATTED STRING FROM 'arrival_date' COLUMN
SET SQL_SAFE_UPDATES = 1; /*Toggling the safe mode to ON*/
ALTER TABLE hotel_reservation DROP COLUMN arrival_date;
ALTER TABLE hotel_reservation CHANGE new_arrival_date arrival_date DATE;
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'hotel_reservation' AND COLUMN_NAME = 'arrival_date';
SELECT DISTINCT YEAR(arrival_date) AS Year FROM hotel_reservation;
SELECT YEAR(arrival_date) AS YEAR, COUNT(Booking_ID) AS Total_Bookings from hotel_reservation GROUP BY YEAR ORDER BY YEAR;

#5. What is the most commonly booked room type?
SELECT * FROM hotel_reservation;
SELECT DISTINCT room_type_reserved FROM hotel_reservation;
SELECT room_type_reserved, COUNT(room_type_reserved) AS Total_Bookings FROM hotel_reservation GROUP BY room_type_reserved ORDER BY room_type_reserved;
#RESULT : Room_Type 1

#6. How many reservations fall on a weekend (no_of_weekend_nights > 0)?
SELECT * FROM hotel_reservation;
SELECT COUNT(Booking_ID) AS Reservations_fall_on_Weekend_nights FROM hotel_reservation WHERE no_of_weekend_nights>0;
SELECT COUNT(Booking_ID) AS Reservations_fall_on_Week_nights FROM hotel_reservation WHERE no_of_week_nights>0;
#RESULT: 383

#7. What is the highest and lowest lead time for reservations?
SELECT * FROM hotel_reservation;
SELECT MAX(lead_time) AS Highest_lead_time FROM hotel_reservation;
SELECT MIN(lead_time) AS Lowest_lead_time FROM hotel_reservation WHERE lead_time>0;

#8. What is the most common market segment type for reservations?
SELECT * FROM hotel_reservation;
SELECT DISTINCT market_segment_type FROM hotel_reservation;
SELECT market_segment_type, COUNT(market_segment_type) AS Total_Bookings FROM hotel_reservation GROUP BY market_segment_type ORDER BY market_segment_type;
#RESULT : Online

#9. How many reservations have a booking status of "Confirmed"?
SELECT * FROM hotel_reservation;
SELECT DISTINCT booking_status FROM hotel_reservation;
SELECT COUNT(Booking_ID) AS Booking_Status_Confirmed FROM hotel_reservation WHERE booking_status='Not_Canceled';
SELECT COUNT(Booking_ID) AS Booking_Status_Confirmed FROM hotel_reservation WHERE booking_status='Canceled';
#RESULT: The booking status column only has "Canceled" and "Not_canceled" but there is no "Confirmed" status

#10. What is the total number of adults and children across all reservations?
SELECT * FROM hotel_reservation;
SELECT SUM(no_of_adults) AS Total_no_of_adults, SUM(no_of_children) AS Total_no_of_children FROM hotel_reservation;

#11. What is the average number of weekend nights for reservations involving children?
SELECT * FROM hotel_reservation;
SELECT AVG(no_of_weekend_nights) AS Avg_no_of_weekend_nights_for_reservations_involving_children FROM hotel_reservation WHERE no_of_children>0;
/*SELECT AVG(no_of_weekend_nights) AS Avg_no_of_weekend_nights_for_reservations_involving_children FROM hotel_reservation WHERE no_of_adults>0;*/
/*SELECT AVG(no_of_weekend_nights) AS Avg_no_of_weekend_nights_for_reservations_involving_children FROM hotel_reservation;*/

#12. How many reservations were made in each month of the year?
SELECT * FROM hotel_reservation;
/*FOR YEAR 2017*/
SELECT DISTINCT MONTH(arrival_date) AS MONTH, COUNT(Booking_ID) AS Total_reservations_2017 FROM hotel_reservation WHERE YEAR(arrival_date)=2017 GROUP BY MONTH(arrival_date) ORDER BY MONTH(arrival_date);
/*FOR YEAR 2018*/
SELECT DISTINCT MONTH(arrival_date) AS MONTH, COUNT(Booking_ID) AS Total_reservations_2018 FROM hotel_reservation WHERE YEAR(arrival_date)=2018 GROUP BY MONTH(arrival_date) ORDER BY MONTH(arrival_date);

#13. What is the average number of nights (both weekend and weekday) spent by guests for each room type?
SELECT * FROM hotel_reservation;
SELECT room_type_reserved, AVG(no_of_weekend_nights), AVG(no_of_week_nights) FROM hotel_reservation GROUP BY room_type_reserved;

#14. For reservations involving children, what is the most common room type, and what is the average price for that room type?
SELECT * FROM hotel_reservation;
SELECT room_type_reserved, AVG(avg_price_per_room) FROM hotel_reservation WHERE no_of_children>0 GROUP BY room_type_reserved ORDER BY room_type_reserved;

#15. Find the market segment type that generates the highest average price per room.
SELECT * FROM hotel_reservation;
SELECT market_segment_type, SUM(avg_price_per_room) AS Highest_avg_price_per_room FROM hotel_reservation GROUP BY market_segment_type ORDER BY market_segment_type;