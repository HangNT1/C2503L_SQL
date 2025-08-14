SELECT * FROM Customers
SELECT * FROM Rentals
SELECT * FROM Movies

SELECT c.FullName
FROM Customers c 
JOIN Rentals r ON c.CustomerID = r.CustomerID
JOIN Movies m ON m.MovieID = r.MovieID
WHERE m.Title = 'Inception'
-- Tên phim nào đã được khách hàng tên “Linh Pham” đặt?
SELECT m.title
FROM Movies m
JOIN Rentals r ON m.MovieID = r.MovieID
JOIN Customers c ON r.CustomerID = c.CustomerID
WHERE c.FullName = 'Linh Pham' 