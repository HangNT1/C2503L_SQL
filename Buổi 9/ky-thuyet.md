# RDBMS (Relational Database Management System)

## Có 2 loại SQL

- **SQL có quan hệ - RDBMS:** SQL Server, MySQL, Oracle, PostgreSQL...
- **SQL không có quan hệ - NoSQL:** không có quan hệ, ví dụ: MongoDB

---

## Buổi 1

### Phân biệt

- SQL (RDBMS & NoSQL)
- Luồng làm việc khi nhận yêu cầu từ phía người dùng

### Các khái niệm

- Database, DBMS & RDBMS, SQL
- Data
- Database
- Data model
- ERM, ERD, Normalization
- Primary key

---

## Buổi 2

### Các khái niệm trong entity

- **PK (Primary key – khóa chính):**

  - Định danh đối tượng
  - Duy nhất (unique)
  - NOT NULL
  - Unique && Not Null
  - Ví dụ: ID (tự tăng), MSSV

- **Unique:** duy nhất, nhưng có thể NULL

  - Một bảng có nhiều unique constraint khác nhau
  - Ví dụ: SinhVien(MSSV, Tên, Tuổi, Địa chỉ, SDT, Email, Giới tính, CCCD)

- **FK (Foreign key):**
  - **1–1:** FK có thể ở một trong hai bảng  
    Ví dụ: Vợ(id, ..., chong_id), Chồng(id, ...)
  - **1–N:** FK đặt ở bảng “N”  
    Ví dụ: GiaDinh – ThànhVien
  - **N–N:** tạo bảng trung gian  
    Ví dụ: SinhVien – MonHoc – ĐăngKy

### Relationship (Quan hệ)

- 1–1: Vợ <-> Chồng
- 1–N: Gia đình <-> Thành viên
- N–N: Sinh viên <-> Môn học

---

## Buổi 3: SQL Server and Query

### Các loại SQL Command

- **DDL (Data Definition Language):** CREATE, ALTER, DROP, TRUNCATE
- **DML (Data Manipulation Language):** INSERT, DELETE, UPDATE

### Các kiểu xóa

- **DROP:** xóa hẳn database/table
- **DELETE:** xóa dữ liệu trong bảng
- **TRUNCATE:** xóa dữ liệu nhưng giữ cấu trúc

### Data type

- Number: int, float
- Character: char, nvarchar…
- Date & Datetime
- Bit: true/false

---

## Buổi 4 & Buổi 5

- Ôn tập: tạo database, bảng, thêm dữ liệu
- SELECT: hiển thị dữ liệu
- WHERE: điều kiện (AND, OR, BETWEEN, LIKE)
- TOP, DISTINCT

---

## Buổi 6

- Thực hành: View, Function, Procedure, Trigger, Index
- T-SQL: khai báo biến, cấu trúc rẽ nhánh, vòng lặp, TRY...CATCH, phân quyền

---

## Buổi 7: Procedure (Stored Procedure)

- Mục đích:
  - Tự động hóa quy trình xử lý dữ liệu (thêm, sửa, xóa, tìm kiếm)
  - Tái sử dụng logic SQL mà không cần viết lại nhiều lần

### Cú pháp

````sql
CREATE OR ALTER PROCEDURE ten_proc (@number INT, @diaChi NVARCHAR(100))
AS
BEGIN
    -- code
    IF (dieu_kien)
    BEGIN
        -- code
    END
END
## Buổi 8
- Thực hành tổng hợp:
  - View
  - Function
  - Procedure
  - Trigger
  - Index

- Các nội dung còn lại:
  - T-SQL và cách khai báo biến
  - Cấu trúc rẽ nhánh, vòng lặp SQL
  - TRY...CATCH và xử lý ngoại lệ
  - Phân quyền

---

## Buổi 9: T-SQL (Transact-SQL)
- Ngôn ngữ mở rộng của SQL (Microsoft)

### SQL chuẩn
- CREATE, INSERT, SELECT, UPDATE, DROP, ALTER, TRUNCATE

### T-SQL bổ sung
- Khai báo biến: `DECLARE @ten_bien KIEU_DU_LIEU`
- Cấu trúc điều khiển: IF...ELSE, WHILE, CASE
- Xử lý lỗi: TRY...CATCH
- Transaction: COMMIT, ROLLBACK
- Khối lệnh: BEGIN...END
- Các hàm sẵn có: GETDATE(), DATEDIFF(), CONVERT(), CAST()

### Transaction
- Giao dịch: giúp đảm bảo tính toàn vẹn dữ liệu
- Ví dụ: chuyển tiền A -> B
  - Trừ A 100k
  - Cộng B 100k
  - Nếu một bước lỗi → rollback về trạng thái ban đầu

### TRY...CATCH
```sql
BEGIN TRY
    -- các lệnh nghi ngờ có lỗi
END TRY
BEGIN CATCH
    -- rollback, xử lý lỗi
END CATCH
````
