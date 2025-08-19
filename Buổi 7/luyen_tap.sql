CREATE DATABASE CL2505;
GO
USE CL2505;
GO

CREATE TABLE GiangVien (
    MaGiangVien INT PRIMARY KEY,                
    TenGiangVien NVARCHAR(100) NOT NULL,            
    TenTaiKhoan NVARCHAR(100) NOT NULL,            
    SoDienThoai NVARCHAR(15)
);
CREATE TABLE MonHoc (
    MaMonHoc INT PRIMARY KEY,                       
    TenMonHoc NVARCHAR(100) NOT NULL,               
    SoTinChi INT NOT NULL,                          
    SoHocPhan INT
);
CREATE TABLE PhanCongGiangVien (
    MaGiangVien INT,                               
    MaMonHoc INT,                                   
    SoLanDay INT,
    TiLeDo DECIMAL(5,2),
    PRIMARY KEY (MaGiangVien, MaMonHoc),            
    FOREIGN KEY (MaGiangVien) REFERENCES GiangVien(MaGiangVien),
    FOREIGN KEY (MaMonHoc) REFERENCES MonHoc(MaMonHoc)
);
GO
CREATE OR ALTER PROCEDURE ThemGiangVien
    @MaGV INT,
    @TenGV NVARCHAR(100),
    @TaiKhoan NVARCHAR(100),
    @SDT NVARCHAR(15)
AS
BEGIN
    INSERT INTO GiangVien(MaGiangVien, TenGiangVien, TenTaiKhoan, SoDienThoai)
    VALUES (@MaGV, @TenGV, @TaiKhoan, @SDT)
END;
GO
EXEC ThemGiangVien 1, N'Nguyễn Văn A', 'nguyenvana', '0901234567';
EXEC ThemGiangVien 2, N'Trần Thị B', 'tranthib', '0902345678';
EXEC ThemGiangVien 3, N'Lê Văn C', 'levanc', '0903456789';

GO
CREATE OR ALTER PROC them_mon_hoc
    @MaMonHoc INT,
    @TenMonHoc NVARCHAR(100),               
    @SoTinChi INT ,                          
    @SoHocPhan INT
AS
BEGIN
    INSERT into MonHoc(MaMonHoc,
    TenMonHoc ,               
    SoTinChi,                          
    SoHocPhan)
    VALUES (@MaMonHoc,
    @TenMonHoc,               
    @SoTinChi ,                          
    @SoHocPhan)
END
EXEC them_mon_hoc @MaMonHoc=1,@TenMonHoc= N'toánas',
    @SoTinChi=2, @SoHocPhan=5

