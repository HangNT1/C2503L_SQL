CREATE DATABASE HousingManagement

USE HousingManagement

CREATE TABLE Owners(
    OwnerID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(10) UNIQUE CHECK(Phone NOT LIKE '%[^0-9]%'),
    Email NVARCHAR(120) UNIQUE,
    IsActive BIT DEFAULT 1
)
CREATE TABLE Houses(
    HouseID INT PRIMARY KEY IDENTITY(1,1),
    Addres NVARCHAR(120) NOT NULL,
    Area INT NOT NULL CHECK(Area>0),
    Price DECIMAL(8,2) NOT NULL CHECK(Price>0),
    OwnerID INT NULL,
    FOREIGN KEY (OwnerID) REFERENCES Owners(OwnerID) ON DELETE SET NULL, 
)
GO

CREATE TABLE Contracts(
    ContractID INT IDENTITY(1,1) PRIMARY KEY,
    HouseID INT NOT NULL FOREIGN KEY REFERENCES Houses(HouseID) ON DELETE CASCADE,
    BuyerName NVARCHAR(100) NOT NULL,
    SignDate DATE NOT NULL,
    TotalValue DECIMAL(18,2) NOT NULL CHECK(TotalValue > 0)
)
GO
INSERT INTO Owners(FullName,Phone,Email,IsActive) VALUES
('Đoàn Việt Hoàng','0123456789','Hoàng@gmail.com',1),
('Đặng Thị Ngọc Anh','0123456779','Ngocanh@gmail.com',1),
('Đoàn Việt Trung','0123856789','Trung@gmail.com',1)

INSERT INTO Houses ([Addres], Area, Price, OwnerID)VALUES 
(N'123 Lê Lợi, Q.1', 100, 150.3, 1),
(N'456 Trần Hưng Đạo, Q.5', 80, 150.3, 2),
(N'789 Nguyễn Trãi, Q.10', 60, 200.3, NULL); 


INSERT INTO Contracts (HouseID, BuyerName, SignDate, TotalValue)
VALUES 
(4, N'Phạm Văn D', '2025-08-01', 1500000000),
(5, N'Ngô Thị E', '2025-08-05', 1200000000),
(6, N'Bui Van', '2025-08-05', 120);

SELECT * FROM Contracts
SELECT * FROM Houses
SELECT * FROM Owners

-- Hiển thị danh sách chủ nhà sở hữu của các chủ nhà có tên chứa chữ a 
SELECT * 
FROM Owners
WHERE FullName LIKE '%a%' 
-- Hiển thị danh sách chủ nhà sở hữu có id trong khoảng từ 1-3 
-- và ở trạng thái active 
SELECT *
FROM Owners
WHERE OwnerID BETWEEN 1 AND 3
AND IsActive =1
-- Hiển thị những hợp đồng thuê được mua bởi những người 
-- tên bắt đầu bằng chữ “B” và có tổng giá trị hợp đồng lớn hơn 100 
SELECT *
FROM Contracts
WHERE BuyerName LIKE 'B%'
AND TotalValue >100
-- Hiển thị tất cả thông tin các căn nhà có giá thuê nằm 
-- trong khoảng từ 5 triệu đến 10 triệu.
SELECT *
FROM Houses
WHERE Price BETWEEN 50 AND 100

-- Liệt kê danh sách chủ nhà có tên chứa chữ “an” (không phân biệt hoa thường).
SELECT *
FROM Owners
WHERE LOWER(FullName) LIKE '%an'

-- Hiển thị các hợp đồng thuê nhà được ký sau năm 2022.
SELECT *
FROM Contracts
WHERE YEAR(SignDate) > 2022 
-- Them cot Active cho bang Hourses
ALTER TABLE Houses
ADD Active BIT DEFAULT 1; 
-- Liệt kê các căn nhà thuộc quận “1” và có tình trạng đang hoạt động (Active).
SELECT * 
FROM Houses
WHERE Addres = '%Q.1' 
AND Active = 1
-- Hiển thị thông tin các chủ nhà có ID nằm trong danh sách 1, 3, 5, 7.
SELECT * 
FROM OWNERs 
WHERE OWNERID IN (1,3,5,7)
-- Hiển thị các hợp đồng thuê có TongGiaTri lớn hơn 100 triệu 
--b và được sắp xếp theo thứ tự giảm dần của TongGiaTri.
-- Sap xep - ORDER BY (LUON LUON O VI TRI CUOI CUNG TRONG CAU QUERY)
-- Neu k ghi gi => tu dong hien la sap xep theo tang dan (ASC)
-- Giam dan: DESC
SELECT * 
FROM Contracts
WHERE TotalValue > 100
ORDER BY TotalValue DESC
-- Liệt kê thông tin các căn nhà không nằm trong danh sách ID 
-- của các căn nhà đã từng được thuê.
-- Hourse , Contract
SELECT * 
FROM Houses 
WHERE houseID NOT IN (
    -- Truy van con (sub query): Liet ke ra danh sach hourse ID da tung duoc thue tung
    SELECT DISTINCT houseID FROM Contracts
)
-- Hiển thị thông tin các hợp đồng thuê mà người thuê có họ bắt đầu bằng chữ "B".

-- Liệt kê các chủ nhà mà hiện chưa sở hữu bất kỳ căn nhà nào (gợi ý: sử dụng NOT EXISTS).
-- Houses, Owners 
SELECT * FROM Houses
SELECT * FROM Owners
SELECT *
FROM OWNERs o
WHERE NOT EXISTS (
    SELECT 1
    FROM Houses h 
    WHERE h.OWNERid = o.OWNERid
)
-- Truy van nang cao 
-- Thống kê số lượng căn nhà mà mỗi chủ nhà đang sở hữu (dùng bảng Nha).
SELECT OWNERID, COUNT(*) as N'Đếm số lượng nhà theo chủ nhà '
FROM Houses
GROUP BY OWNERID -- gom nhóm
SELECT * FROM Houses
-- OwnerID 
-- 1 => 4 
-- 2 => 3
-- 3 => 1 
-- Tính tổng giá trị các hợp đồng thuê của từng người thuê (dùng bảng HopDongThue).
SELECT BuyerName, SUM(TotalValue) 
FROM Contracts
GROUP BY BuyerName
-- Tìm người thuê có số hợp đồng thuê lớn hơn hoặc bằng 2 (dùng bảng HopDongThue).
-- Theo ly thuyet => WHERE 
SELECT * FROM Contracts
SELECT BuyerName, SUM(TotalValue) 
FROM Contracts
GROUP BY BuyerName
HAVING COUNT(*) >= 2
-- Tính diện tích trung bình của các căn nhà theo từng quận (dùng bảng Nha).
-- Thống kê số lượng hợp đồng thuê theo từng năm (dựa trên NgayBatDau trong bảng HopDongThue).
-- Tìm các chủ nhà có tổng giá trị các căn nhà đang sở hữu vượt quá 5 tỷ đồng (bảng Nha).
-- Thống kê số lượng người thuê theo từng quận họ đang sinh sống (bảng NguoiThue).
-- Tính tổng tiền thuê theo từng chủ nhà thông qua các hợp đồng thuê (JOIN Nha, ChuNha, HopDongThue).
-- Tìm các quận có trung bình giá thuê lớn hơn 15 triệu (bảng Nha).
-- Tìm người thuê có tổng tiền thuê thấp nhất (bảng HopDongThue).
-- Thống kê số lượng hợp đồng thuê theo từng tình trạng hợp đồng (TinhTrang), bảng HopDongThue.
-- Liệt kê tên chủ nhà và số lượng căn nhà họ sở hữu, chỉ hiện những người sở hữu từ 2 căn trở lên (bảng ChuNha, Nha).
-- Tìm các quận có nhiều hơn 5 căn nhà đang hoạt động (bảng Nha).
-- Thống kê số hợp đồng thuê theo từng tháng trong năm 2024 (dùng MONTH(NgayBatDau) và YEAR).
-- Tính trung bình diện tích nhà theo từng tình trạng (TinhTrang) (bảng Nha).
-- Tìm chủ nhà có tổng số diện tích các căn nhà họ sở hữu lớn nhất (bảng Nha, ChuNha).
-- Liệt kê các người thuê có tổng giá trị hợp đồng thuê nằm trong top 3 cao nhất (bảng HopDongThue).
-- Tìm người thuê có nhiều hợp đồng thuê nhất trong năm 2023.
-- Tìm quận có nhiều người thuê nhất và số lượng người thuê tương ứng.
-- Tính tổng giá trị thuê nhà trong mỗi quý của năm 2023 (dựa theo NgayBatDau, GROUP BY quý).

