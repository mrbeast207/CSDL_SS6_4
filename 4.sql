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
-- dữ liệu mẫu của AI 
DELIMITER //
CREATE PROCEDURE GenerateHotelData()
BEGIN
    DECLARE i INT DEFAULT 1;
    -- Thêm 3 khách sạn mẫu
    INSERT INTO Hotels VALUES (1, 'Hotel Xuất Sắc'), (2, 'Hotel Ít Khách'), (3, 'Hotel Giá Rẻ');
    -- 1. Sinh dữ liệu cho Hotel 1 (Đạt chuẩn: 60 đơn, giá 3.5tr - 5tr)
    SET i = 1;
    WHILE i <= 60 DO
        INSERT INTO Bookings (hotel_id, total_price, status) 
        VALUES (1, FLOOR(3500000 + RAND() * 1500000), 'COMPLETED');
        SET i = i + 1;
    END WHILE;
    -- 2. Sinh dữ liệu cho Hotel 2 (Thiếu số lượng: 20 đơn, giá 5tr)
    SET i = 1;
    WHILE i <= 20 DO
        INSERT INTO Bookings (hotel_id, total_price, status) 
        VALUES (2, 5000000, 'COMPLETED');
        SET i = i + 1;
    END WHILE;
    -- 3. Sinh dữ liệu cho Hotel 3 (Thiếu giá trị: 60 đơn, giá 1tr - 2tr)
    SET i = 1;
    WHILE i <= 60 DO
        INSERT INTO Bookings (hotel_id, total_price, status) 
        VALUES (3, FLOOR(1000000 + RAND() * 1000000), 'COMPLETED');
        SET i = i + 1;
    END WHILE;
END 
DELIMITER ;
CALL GenerateHotelData();
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