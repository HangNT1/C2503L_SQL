CREATE DATABASE UniTeaching
GO
USE UniTeaching
GO
CREATE TABLE Departments (
    DeptCode VARCHAR(10) PRIMARY KEY,
    [Name] NVARCHAR(100) NOT NULL UNIQUE,
)

CREATE TABLE Lecturers (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(120),
    Phone VARCHAR(10) UNIQUE, CHECK (Phone NOT LIKE '%[^0-9]%'),
    Email NVARCHAR(120) UNIQUE,
    AcademicRank NVARCHAR(30) NOT NULL CHECK (AcademicRank IN (N'Assistant', N'Associate',N'Professor',N'Lecturer')),
    DeptCode VARCHAR(10) NULL, 
    isActive BIT DEFAULT 1,
    FOREIGN KEY (DeptCode) REFERENCES Departments(DeptCode) ON DELETE SET NULL
)

CREATE TABLE Courses (
    CourseID INT IDENTITY(1,1) PRIMARY KEY,
    Code VARCHAR(20) NOT NULL UNIQUE,
    Title NVARCHAR(150) NOT NULL,
    Credits INT NOT NULL CHECK (Credits > 0),
    DeptCode VARCHAR(10) NOT NULL,
    FOREIGN KEY (DeptCode) REFERENCES Departments(DeptCode) ON DELETE NO ACTION
)

CREATE TABLE Classes(
    ClassID INT IDENTITY(1,1) PRIMARY KEY,
    CourseID INT NOT NULL FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE,
    Semester VARCHAR(10) NOT NULL,
    SectionNo INT NOT NULL CHECK( SectionNo > 0),
    Room NVARCHAR(20) NULL,
    Capacity INT NOT NULL CHECK(Capacity > = 0)
)

CREATE TABLE TeachingAssignments(
    TeachingAssignmentID INT IDENTITY(1,1) PRIMARY KEY,
    ClassID INT NOT NULL FOREIGN KEY (ClassID) REFERENCES Classes(ClassID),
    LecturerID INT NOT NULL FOREIGN KEY (LecturerID) REFERENCES Lecturers(ID),
    Hours INT NOT NULL CHECK(Hours > 0) 
)
INSERT INTO Departments (DeptCode, Name) VALUES
('FIT', N'Công nghệ thông tin'),
('FBA', N'Kinh doanh');
INSERT INTO Lecturers (FullName, Phone, Email, AcademicRank, DeptCode, IsActive) VALUES
(N'Nguyễn Văn A', '0912345678', 'a@uni.edu', N'Lecturer', 'FIT', 1),
(N'Trần Thị B', '0909999999', 'b@uni.edu', N'Assistant', 'FIT', 1),
(N'Lê Minh C', NULL, 'c@uni.edu', N'Associate', 'FBA', 1);
INSERT INTO Courses (Code, Title, Credits, DeptCode) VALUES
('DBI221', N'Cơ sở dữ liệu1', 1, 'FIT'),
('PRJ301', N'Web Java', 3, 'FIT'),
('MKT101', N'Nguyên lý Marketing', 3, 'FBA');
INSERT INTO Classes (CourseID, Semester, SectionNo, Room, Capacity) VALUES
(1, '2025A', 1, N'A101', 40),
(2, '2025A', 1, N'A102', 35);
INSERT INTO TeachingAssignments (ClassID, LecturerID, Hours) VALUES
(1, 1, 45),
(2, 2, 45);

SELECT * FROM Departments
SELECT * FROM Lecturers
SELECT * FROM Courses
SELECT * FROM Classes
SELECT * FROM TeachingAssignments
-- Phần A – SELECT cơ bản
-- Truy vấn tất cả cột từ bảng Courses.
SELECT *
FROM Courses
-- Truy vấn các cột Code, Title, Credits từ bảng Courses (đặt bí danh cột theo ý bạn).
SELECT Code as N'Mã khoá học', Title, Credits
FROM Courses
-- Truy vấn các cột FullName, Email, AcademicRank từ bảng Lecturers.
SELECT FullName, Email, AcademicRank
FROM Lecturers
-- Truy vấn các cột DeptCode, Name từ bảng Departments.
SELECT DeptCode, Name
FROM Departments
-- Truy vấn các cột ID, CourseID, Semester, SectionNo, Room, Capacity từ bảng Classes.
SELECT ClassID, CourseID, Semester,SectionNo, Room,Capacity
FROM Classes
-- Phần B – SELECT có điều kiện (WHERE, LIKE, BETWEEN, IN/NOT IN, IS NULL, toán tử)
-- Truy vấn các dòng trong bảng Courses với điều kiện so sánh đơn giản trên Credits (ví dụ bằng/khác).
-- Hien thi danh sach cac khoa hoc co chung chi(credits) nho 3
SELECT *
FROM Courses
WHERE credits < 3
-- Truy vấn các dòng trong bảng Lecturers với điều kiện trạng thái IsActive.
SELECT * 
FROM Lecturers 
WHERE isActive = 1
-- Truy vấn các cột FullName, Email từ bảng Lecturers với điều kiện FullName chứa một từ khóa (dùng LIKE).
-- Truy vấn bảng Courses với điều kiện Code bắt đầu bằng một tiền tố (dùng LIKE).
SELECT * 
FROM Courses 
-- WHERE Code LIKE 'DBI%' -- Bat dau bang
-- WHERE Code LIKE '%01' -- Ket thuc bang
WHERE Code LIKE '%1%' -- Chua ky tu 
-- Truy vấn bảng Courses với điều kiện Credits nằm trong một khoảng 0-2 (dùng BETWEEN).
SELECT * 
FROM Courses 
WHERE credits >=0 AND credits <=2
SELECT * 
FROM Courses 
WHERE credits BETWEEN 0 AND 2 
-- Truy vấn bảng Courses với điều kiện Code không khớp một mẫu cho trước (dùng NOT LIKE).
-- Truy vấn bảng Courses với điều kiện DeptCode thuộc một tập giá trị (dùng IN).
-- Truy vấn bảng Lecturers với điều kiện DeptCode không thuộc một tập giá trị (dùng NOT IN; tự xử lý trường hợp NULL nếu có).
-- Truy vấn bảng Lecturers để lọc Phone là NULL hoặc Email không phải NULL (dùng IS NULL / IS NOT NULL).
-- Truy vấn bảng Classes với điều kiện Semester khớp mẫu một niên học/học kỳ cụ thể (dùng LIKE với ký tự đại diện).