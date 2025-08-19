-- procedure (proc)
-- Muc dich: 
    -- Tu dong quy trinh xu ly du lieu (them, sua, xoa seach)
    -- Tai su dung logic cua SQL ma k can viet lai cau lenh SQL 
-- Cu phap: 
-- CREATE OR ALTER PROCEDURE ten_proc (@number INT, @diaChi NVARCHAR(100))
-- AS 
-- BEGIN 
--     -- CODE 
--         IF (dieu kien)
--             BEGIN 
--                 -- code
--             END
-- END
-- 1 khoi lenh {}
-- SQL: BEGIN...END
-- function test(){
-- }
-- int number; 
-- var/const/let ten bien;
-- DECLARE @dia_chi NVARCHAR(100)
-- Tạo procedure hiển thị toàn bộ thông tin từ bảng Owners
CREATE OR ALTER PROC pro_hien_thi1 
AS 
BEGIN 
    SELECT * FROM OWNERs
END 
-- Goi procedure: EXEC ten_pro
EXEC pro_hien_thi1
GO
-- Tạo procedure tìm nhà theo Address. 
CREATE OR ALTER PROC pro_tim_nha 
    (@diaChi NVARCHAR(100))
AS 
BEGIN 
    SELECT * FROM Houses WHERE addres LIKE '%' + @diaChi + '%'
END
GO
EXEC pro_tim_nha @diaChi ='o'
-- Tao procedure them vao du lieu vao bang owners 
GO
CREATE OR ALTER PROC pro_them1 
    (@FullName NVARCHAR(100), @Phone NVARCHAR(10), @Email NVARCHAR(120), @IsActive BIT)
AS
BEGIN
    INSERT INTO Owners 
    VALUES (@FullName, @Phone, @Email, @IsActive)
END
GO 
EXEC pro_them1 
    @FullName = 'Tran Thu Trang' ,
    @Phone = '0918734073',
    @Email = 'hihih55i@gmail.com',
    @IsActive = 1
SELECT * FROM Owners
-- Tao procedure hien thi so luong nha khi biet owerID
SELECT COUNT(*), OWNERID FROM Houses 
GROUP BY OWNERID
GO
CREATE OR ALTER PROC pro_hien_thi_so_luong_nha 
    (
        @owerID INT, -- bien dau vao (truyen khi goi procedure)
        @soLuong INT OUTPUT -- ket qua tra ra cua procedure
    )
AS 
BEGIN 
    SELECT @soLuong = COUNT(*)
    FROM Houses 
    WHERE OWNERID = @owerID
END
DECLARE @SL INT;
EXEC pro_hien_thi_so_luong_nha @owerID =  2, @soLuong = @SL OUTPUT 
PRINT @SL
-- Tạo procedure thêm một hợp đồng mới vào bảng Contracts. 
-- Nhung yeu cau kiem tra dau vao hop ly
GO 
CREATE OR ALTER PROC pro_test1
    (   @houseID INT , 
        @buyerName NVARCHAR(100),
        @SignDate DATE, 
        @totalValue DECIMAL(18,2)
    )
AS 
BEGIN 
    -- Kiem tra du lieu vao khong phep null hoac rong 
    IF (@houseID IS NULL OR @buyerName IS NULL OR @SignDate IS NULL 
         OR LEN(@buyerName) = 0 OR @totalValue IS NULL )
         BEGIN 
                -- Bi loi => RAISERROR: ngoai le trong SQL 
                -- RAISERROR(messloi,muc do nguy hiem, trang thai cua nguoi thai)
                -- + muc do nguy hiem (SEVERITY): 0- 25 muc do 
                --     + 0-> 10: thong canh bao - thuong khong gay ra loi 
                --     + 11->16: loi do nguoi dung: vi pham khoa ngoai, du lieu khong le 
                --     + 17-19 : loi cua he thong 
                --     + 20-25: loi gay nghiem trong 
                -- + state: trang thai cua nguoi dung - do nguoi dung tu quy dinh
                RAISERROR('Dữ liệu không hợp lệ',16,1)
                RETURN
         END
    -- Khoa ngoai khong ton tai 
    IF NOT EXISTS (SELECT 1 FROM Houses WHERE HouseID = @houseID) 
    BEGIN
        RAISERROR('Hourse ID khong ton tai ',16,1)
        RETURN
    END 
    -- Kiem tra totalValue >0 
    IF @totalValue <=0 
    BEGIN
        RAISERROR('Total Value phai la so nguyen duong ',16,1)
        RETURN
    END 
    -- sau khi moi thu oke => insert 
    INSERT INTO Contracts 
    VALUES (@houseID,@buyerName,@SignDate, @totalValue)
END 
GO
EXEC pro_test1 @houseID = 4 , @buyerName = NULL,
    @SignDate ='2025-08-01', @totalValue = -1
-- SELECT * FROM Contracts
-- -- kiem tra null 
-- CREATE TABLE a(
--     id int PRIMARY key, -- duy nhat khong duoc phep null
--     name nvarchar(100)  -- default gia tri cua 1 cot la null 
-- )
-- INSERT into a 
-- VALUES
--     (2,NULL)
-- SELECT * FROM a
-- Tạo procedure xóa một House theo HouseID.
-- Tạo procedure cập nhật số điện thoại của Owner theo OwnerID.
-- Tạo procedure đếm số lượng Houses thuộc về một Owner.
-- Tạo procedure trả về danh sách hợp đồng có TotalValue lớn hơn giá trị X (tham số truyền vào).
-- Tạo procedure hiển thị danh sách Houses chưa có hợp đồng nào.
-- Tạo procedure hiển thị danh sách chủ nhà (Owners) cùng tổng số nhà mà họ sở hữu.
