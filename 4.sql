create database s;
use s;
CREATE TABLE Hotels (
    hotel_id INT PRIMARY KEY,
    hotel_name VARCHAR(100) NOT NULL
);
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    hotel_id INT,
    total_price DECIMAL(15, 2),
    status VARCHAR(20), -- 'COMPLETED', 'CANCELLED', 'PENDING'
    FOREIGN KEY (hotel_id) REFERENCES Hotels(hotel_id)
);
INSERT INTO Hotels (hotel_id, hotel_name) VALUES
(1, 'Sunshine Hotel'),
(2, 'Ocean View Resort'),
(3, 'Mountain Retreat'),
(4, 'City Central Hotel'),
(5, 'Luxury Palace'),
(6, 'Green Garden Hotel'),
(7, 'Golden River Hotel'),
(8, 'Skyline Tower Hotel'),
(9, 'Blue Lagoon Resort'),
(10, 'Royal Heritage Hotel');
INSERT INTO Bookings (booking_id, hotel_id, total_price, status) VALUES
(101, 1, 150.00, 'COMPLETED'),
(102, 2, 200.50, 'PENDING'),
(103, 3, 320.00, 'COMPLETED'),
(104, 4, 120.75, 'CANCELLED'),
(105, 5, 500.00, 'COMPLETED'),
(106, 6, 220.00, 'PENDING'),
(107, 7, 180.25, 'COMPLETED'),
(108, 8, 275.00, 'CANCELLED'),
(109, 9, 310.40, 'COMPLETED'),
(110, 10, 450.00, 'PENDING');
SELECT 
    h.hotel_name, 
    COUNT(b.booking_id) AS total_completed_bookings, 
    AVG(b.total_price) AS avg_price
FROM Hotels h
JOIN Bookings b ON h.hotel_id = b.hotel_id
WHERE b.status = 'COMPLETED' 
GROUP BY h.hotel_id, h.hotel_name
HAVING COUNT(b.booking_id) >= 50 
   AND AVG(b.total_price) > 3000000;
