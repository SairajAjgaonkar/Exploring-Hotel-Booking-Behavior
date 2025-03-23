#Create Database
CREATE DATABASE IF NOT EXISTS constructweek;

# Select Database
USE constructweek;

#Get Data
SELECT * FROM hotel_booking;

# 1. Overall Cancellation Rate
SELECT 
    COUNT(*) AS total_bookings, 
    SUM(CASE WHEN booking_status = 1 THEN 1 ELSE 0 END) AS total_cancellations, 
    (SUM(CASE WHEN booking_status = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS cancellation_rate
FROM hotel_booking; 

#2. Cancellation Rate by Market Segment
SELECT 
    market_segment_type, 
    COUNT(*) AS total_bookings, 
    SUM(CASE WHEN booking_status = 1 THEN 1 ELSE 0 END) AS total_cancellations, 
    (SUM(CASE WHEN booking_status = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS cancellation_rate
FROM hotel_booking
GROUP BY market_segment_type
ORDER BY cancellation_rate DESC;

#3. Booking Trends by Month
SELECT 
    arrival_month, 
    COUNT(*) AS total_bookings
FROM hotel_booking
GROUP BY arrival_month
ORDER BY total_bookings DESC;

#4. Most Popular Room Type
SELECT 
    room_type_reserved, 
    COUNT(*) AS total_bookings
FROM hotel_booking
GROUP BY room_type_reserved
ORDER BY total_bookings DESC
LIMIT 1;

#5. Repeat vs. First-Time Customers
SELECT 
    CASE 
        WHEN no_of_previous_bookings_not_canceled > 0 THEN 'Repeat Customer'
        ELSE 'First-Time Customer'
    END AS customer_type,
    COUNT(*) AS total_bookings
FROM hotel_booking
GROUP BY customer_type;