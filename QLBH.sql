CREATE DATABASE QLBH
GO
USE QLBH;

--                  Câu 1                  --                    
CREATE TABLE SanPham (
	maSP char(10),
	tenSP nvarchar(50),
	dvTinh nvarchar(30),
	nuocSX nvarchar(50),
	gia float,
	soLuong float,

	PRIMARY KEY (maSP)
);
GO
CREATE TABLE ChiTietHD (
	soHD char(10),
	maSP char(10),
	soLuong float,
	giaBan float,

	PRIMARY KEY (soHD),
	FOREIGN KEY (maSP) REFERENCES SanPham(maSP)
);
GO
CREATE TABLE NhanVien (
	maNV char(10),
	hoTenNV nvarchar(60),
	ngaySinh date,
	gioiTinh nchar(10),
	ngayLamViec date,
	sdt char(10),
	email nchar(30),

	PRIMARY KEY (maNV)
);
GO
CREATE TABLE KhachHang (
	maKH char(10),
	hoTenKH nvarchar(50),
	diaChi nvarchar(100),
	sdt char(10),
	ngaySinh date,
	doanhSO float,

	PRIMARY KEY (maKH)
);
GO
CREATE TABLE HoaDon (
	soHD char(10),
	ngayHD date,
	maKH char(10),
	maNV char(10),
	triGia float,

	PRIMARY KEY (soHD),
	FOREIGN KEY (soHD) REFERENCES ChiTietHD(soHD),
	FOREIGN KEY (maNV) REFERENCES NhanVien(maNV),
	FOREIGN KEY (maKH) REFERENCES KhachHang(maKH)
);
GO

ALTER TABLE NhanVien
ADD CONSTRAINT check_NhanVien_age CHECK (DATEDIFF(year, ngaySinh, GETDATE()) >= 18);
GO

ALTER TABLE KhachHang
ADD CONSTRAINT unique_KhachHang_sdt UNIQUE(sdt);
GO

ALTER TABLE SanPham
ADD CONSTRAINT check_SanPham_soLuong CHECK (soLuong > 9);
GO

--                  Câu 2                  --    

INSERT INTO SanPham (maSP, tenSP, dvTinh, nuocSX, gia, soLuong) VALUES 
('SP001', N'Sữa tươi Vinamilk', N'Hộp', N'Việt Nam', 20000, 1000),
('SP002', N'Trứng gà', N'Quả', N'Việt Nam', 5000, 5000),
('SP003', N'Bánh quy Oreo', N'Hộp', N'Mỹ', 30000, 200),
('SP004', N'Chả cá', 'Kg', N'Việt Nam', 150000, 30),
('SP005', N'Nước tăng lực Red Bull', 'Lon', N'Thái Lan', 25000, 300);
GO

INSERT INTO ChiTietHD (soHD, maSP, soLuong, giaBan) VALUES 
('HD001', 'SP001', 2, 40000),
('HD002', 'SP002', 100, 500000),
('HD003', 'SP003', 10, 300000),
('HD004', 'SP001', 3, 60000),
('HD005', 'SP004', 2, 300000),
('1', 'SP001', 2, 40000);
GO

INSERT INTO KhachHang (maKH, hoTenKH, diaChi, sdt, ngaySinh, doanhSo) VALUES 
(N'KH001', N'Nguyễn Văn A', N'Hà Nội', '0987654321', '1990-01-01', 20000000),
(N'KH002', N'Trần Thị G', N'Hồ Chí Minh', '0912345698', '1995-05-13', 15000000),
(N'KH003', N'Lê Văn H', N'Hà Nội', '0977125676', '1998-12-25', 37700000),
('KH004', N'Phạm Thị I', N'Đà Nẵng', '0945612122', '1999-08-10', 25600000),
('KH005', N'Nguyễn Thanh K', N'Hà Nội', '0905120956', '2000-11-5', 18000000),
('KH006', N'Nguyễn Thành Dương', N'Phú Thọ', '0963454321', '2002-01-04', 0);
GO

INSERT INTO NhanVien (maNV, hoTenNV, ngaySinh, gioiTinh, ngayLamViec, sdt, email) VALUES 
('NV001', N'Nguyễn Văn A', '1990-01-01', 'Nam', '2015-05-01', '0987654321', 'nv.a@abc.com'),
('NV002', N'Trần Thị B', '1995-05-12', 'Nữ', '2018-01-01', '0912345678', 'nv.b@abc.com'),
('NV003', N'Lê Văn C', '1988-12-25', 'Nam', '2010-07-01', '0977123456', 'nv.c@abc.com'),
('NV004', N'Phạm Thị D', '1993-06-20', 'Nữ', '2019-05-01', '0945678912', 'nv.d@abc.com'),
('NV005', N'Nguyễn Thanh E', '1997-11-15', 'Nam', '2021-01-01', '0905123456', 'nv.e@abc.com');
GO

INSERT INTO HoaDon (soHD, ngayHD, maKH, maNV, triGia) VALUES
('HD001', '2022-01-01', 'KH001', 'NV001', 500000),
('HD002', '2022-02-05', 'KH002', 'NV002', 800000),
('HD003', '2022-03-10', 'KH001', 'NV003', 1000000),
('HD004', '2022-04-15', 'KH003', 'NV002', 600000),
('HD005', '2022-05-20', 'KH002', 'NV001', 900000),
('1', '2022-01-09', 'KH001', 'NV001', 500000);
GO

--                  Câu 3                  --

SELECT maSP, tenSP, soLuong
FROM SanPham;
GO

SELECT maNV, hoTenNV, ngayLamViec
FROM NhanVien;
GO

SELECT diaChi, sdt
FROM KhachHang
WHERE diaChi LIKE '%Hà Nội%';
GO

SELECT maSP, tenSP
FROM SanPham
WHERE gia > 100000 AND soLuong < 50;
GO

SELECT *
FROM KhachHang
WHERE doanhSO = 0;
GO

SELECT *
FROM SanPham
WHERE nuocSX <> 'Việt Nam';
GO

SELECT KhachHang.hoTenKH, NhanVien.hoTenNV, HoaDon.triGia
FROM HoaDon
INNER JOIN KhachHang ON HoaDon.maKH = KhachHang.maKH
INNER JOIN NhanVien ON HoaDon.maNV = NhanVien.maNV
WHERE HoaDon.soHD = '1';
GO

SELECT maNV, hoTenNV, gioiTinh, ngayLamViec,email
FROM NhanVien JOIN KhachHang ON NhanVien.sdt = KhachHang.sdt
WHERE NhanVien.sdt IS NOT NULL;
GO

--                  Câu 4                  --    

CREATE VIEW View_1 AS
SELECT maSP, tenSP, soLuong
FROM SanPham;
GO

CREATE VIEW View_2 AS
SELECT maNV, hoTenNV, ngayLamViec
FROM NhanVien;
GO

CREATE VIEW View_3 AS
SELECT diaChi, sdt
FROM KhachHang
WHERE diaChi LIKE '%Ha Noi%';
GO

CREATE VIEW View_4 AS
SELECT maSP, tenSP
FROM SanPham
WHERE gia > 100000 AND soLuong < 50;
GO

CREATE VIEW View_5 AS
SELECT *
FROM KhachHang
WHERE doanhSO = 0;
GO

CREATE VIEW View_6 AS
SELECT *
FROM SanPham
WHERE nuocSX <> 'Việt Nam';
GO

CREATE VIEW View_7 AS
SELECT KhachHang.hoTenKH, NhanVien.hoTenNV, HoaDon.triGia
FROM HoaDon
INNER JOIN KhachHang ON HoaDon.maKH = KhachHang.maKH
INNER JOIN NhanVien ON HoaDon.maNV = NhanVien.maNV
WHERE HoaDon.soHD = '1';
GO

CREATE VIEW View_8 AS
SELECT maNV, hoTenNV, gioiTinh, ngayLamViec,email
FROM NhanVien JOIN KhachHang ON NhanVien.sdt = KhachHang.sdt
WHERE NhanVien.sdt IS NOT NULL;
GO
