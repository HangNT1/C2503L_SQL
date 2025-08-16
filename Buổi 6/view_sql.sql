-- View: Giong bang tam(bang ao) 
-- Duoc tao ra tu cau lenh select. 
-- No khong luu tru du lieu truc tiep ma chi duoc luu truy cau truy van khi gon 
-- View => 1 bang tam (duoc lay ra tu 1 hoac nhieu bang khac)
-- Cau truc: 
-- CREATE VIEW ten_view AS 
-- -- viet cau lenh select 
-- SELECT col_1,col_2
-- FROM table1,table2
-- WHERE dieu kien (co the co join)
USE HousingManagement
SELECT * FROM Contracts
SELECT * FROM Owners
SELECT * FROM Houses

-- Đề bài: Tạo view hiển thị danh sách tất cả các chủ nhà bao gồm tên và số điện thoại.
GO
CREATE VIEW view_hourses AS 
SELECT FullName,Phone
FROM Owners
GO 
SELECT * FROM view_hourses
-- Đề bài: Tạo view hiển thị danh sách các căn nhà có diện tích trên 100m²
-- và giá lớn hơn 1 tỷ.
GO
ALTER VIEW View1 AS
SELECT *
FROM Houses
WHERE Area > 80 AND Price > 100
GO
SELECT * FROM View1
-- Đề bài: Tạo view hiển thị thông tin hợp đồng có tên người mua bắt đầu bằng chữ “B”.
GO
CREATE VIEW view_contracts AS
SELECT * FROM Contracts
WHERE BuyerName LIKE 'B%'
GO
SELECT * FROM view_contracts
-- Đề bài: Tạo view hiển thị tất cả hợp đồng có tổng giá trị lớn hơn 500 triệu,
--  sắp xếp theo TotalValue giảm dần.
GO 
ALTER VIEW view_3
AS
SELECT TOP 100 *
FROM Contracts
WHERE TotalValue >500000000
ORDER BY TotalValue DESC
GO
SELECT * FROM view_3
GO
CREATE VIEW view_3_1
AS
SELECT  *
FROM Contracts
WHERE TotalValue >500000000
GO
SELECT * FROM view_3_1 
ORDER BY TotalValue DESC
-- Đề bài: Tạo view hiển thị danh sách địa chỉ căn nhà và tên chủ nhà tương ứng.
GO
ALTER VIEW view_4
AS
SELECT DISTINCT c.Addres,o.FullName
FROM Houses c 
JOIN Owners  o on o.OwnerID=c.OwnerID
GO
SELECT  * FROM view_4

-- Đề bài: Tạo view thống kê tổng số căn nhà mà mỗi chủ nhà sở hữu.
GO
CREATE VIEW view_5
AS 
SELECT o.OwnerID, o.FullName, COUNT(h.HouseID) AS [Hourse Count]
FROM Owners o 
JOIN Houses h ON o.OwnerID = h.OwnerID
GROUP BY o.OwnerID, o.FullName
GO
SELECT * FROM view_5
-- Đề bài: Tạo view hiển thị thông tin hợp đồng: tên người mua, địa chỉ nhà, tên chủ nhà.

-- Đề bài: Tạo view hiển thị các chủ nhà sở hữu tổng giá trị nhà trên 5 tỷ.

-- Đề bài: Tạo view hiển thị những hợp đồng thuộc top 3 giá trị cao nhất.

-- Đề bài: Tạo view thống kê số lượng hợp đồng theo từng năm.




