
-- Bang Danh Muc
CREATE TABLE DanhMucSanPham(
    MaDanhMuc INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    TenDanhMuc VARCHAR(100),
    ImgUrl VARCHAR(200) 
);
Insert into DanhMucSanPham values(DEFAULT, 'Ngao-sò-ốc','s1.png');
Insert into DanhMucSanPham values(DEFAULT, 'Bào Ngư','s2.png');
Insert into DanhMucSanPham values(DEFAULT, 'Tôm','s3.png');
Insert into DanhMucSanPham values(DEFAULT, 'Mực','s4.png');
Insert into DanhMucSanPham values(DEFAULT, 'Cá','s5.png');
Insert into DanhMucSanPham values(DEFAULT, 'Sứa','s6.png');
Insert into DanhMucSanPham values(DEFAULT, 'Sản phẩm đóng hộp','s6.png');

-- Bang San Pham
CREATE TABLE SanPham(
    MaSanPham INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    MaDanhMuc INT NOT NULL REFERENCES DanhMucSanPham(MaDanhMuc),
    TenSanPham VARCHAR(100),
    GiaGoc DOUBLE,
    KhuyenMai DOUBLE,
    DonViTinh VARCHAR(20),
    ImgUrl VARCHAR(200),
    MotaNgan VARCHAR(1000),
    MotaChiTiet LONGTEXT,
    Luotxem DOUBLE,
    SoLuong int
);
Insert into SanPham values(DEFAULT, 1,'Cồi sò điệp',160000,0,'vnd','coi-so-diep-1_master.jpg','Cồi sò điệp ngon bổ dưỡng','Cồi sò điệp ngon bổ dưỡng',0,0);
Insert into SanPham values(DEFAULT, 2,'Ngao 2 Cồi',190000,0,'vnd','ngao-2-coi-1_master.jpg','Ngao 2 Cồi ngon bổ dưỡng','Ngao 2 Cồi ngon bổ dưỡng',0,0);
Insert into SanPham values(DEFAULT, 3,'Tôm hùm tre',1000000,0,'vnd','tom_hum_tre_01_master.jpg','Tôm hùm tre bổ dưỡng','Tôm hùm tre bổ dưỡng',0,0);
Insert into SanPham values(DEFAULT, 4,'Mực Mai',170000,0,'vnd','oc-huong-1_master.jpg','Ngao 2 Cồi ngon bổ dưỡng','Ngao 2 Cồi ngon bổ dưỡng',0,0);
Insert into SanPham values(DEFAULT, 5,'Cá hồi',450000,0,'vnd','so-mai-1_master.jpg','Cá hồi ngon bổ dưỡng','Cá hồi ngon bổ dưỡng',0,0);
Insert into SanPham values(DEFAULT, 6,'Sứa tươi',150000,0,'vnd','hau-sua-1_master.jpg','Sứa tươi ngon bổ dưỡng','Sứa tươi ngon bổ dưỡng',0,0);
Insert into SanPham values(DEFAULT, 7,'Cua',190000,0,'vnd','tom_su_bien_new_1_master.jpg','Cua ngon bổ dưỡng','Cua ngon bổ dưỡng',0,0);


--  Bang Tin Tuc
CREATE TABLE TinTuc(
    MaTinTuc INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    TieuDe VARCHAR(200),
    NgayTao date,
    NoiDung LONGTEXT
);

-- Bang Lien He
CREATE TABLE LienHe(
    MaLienHe INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    HoTen VARCHAR(50),
    Email VARCHAR(100),
    ChuDe VARCHAR(200),
    NoiDung LONGTEXT
);

-- Bang User
CREATE TABLE Users(
    TaiKhoan VARCHAR(50) PRIMARY KEY  NOT NULL,
    MatKhau VARCHAR(50) NOT NULL,
    HoTen VARCHAR(50) NOT NULL,
    GioiTinh TINYINT,
    NgaySinh Datetime,
    DiaChi VARCHAR(200),
    Email VARCHAR(100),
    SoDT VARCHAR(10),
    NhomQuyen INT NOT NULL-- 0: admin, 1:NhanVien, 2: Khách HANG 
);
Insert into Users values('admin','abc123','Vũ',True,'1998-12-18 00:00:00.000','Hà Nội','vutrananh111@gmail.com','0343423398',0);

-- Bang DonHang
CREATE TABLE DonHang(
    MaDonHang INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    MaKhachHang VARCHAR(50) NOT NULL REFERENCES KhachHang(MaKhachHang),
    NgayDatHang DATETIME,
    DiaChi VARCHAR(200),
    Ghichu VARCHAR(300),
    TongTien DOUBLE
);

-- Bang DonHangChiTiet
CREATE TABLE DonHangChiTiet(
    MaDHCT int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    MaDonHang int NOT NULL REFERENCES DonHang(MaDonHang),
    MaSanPham Int NOT NULL REFERENCES SanPham(MaSanPham),
    GiaBan DOUBLE,
    KhuyenMai DOUBLE,
    SoLuong int,
    TongTien DOUBLE
);

-- Bang Barner -- 
CREATE TABLE AnhBia(
    MaAB int PRIMARY KEY AUTO_INCREMENT NOT NULL,
    ImgUrl VARCHAR(200)
);
Insert into AnhBia values(1,'slider_1.jpg');
Insert into AnhBia values(2,'slider_2.jpg');
Insert into AnhBia values(3,'slider_3.jpg');

-- Khachhang-- 
CREATE TABLE KhachHang(
    MaKhachHang VARCHAR(50) PRIMARY KEY  NOT NULL,
    MatKhau VARCHAR(50) NOT NULL,
    HoTen VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    SoDT VARCHAR(10),
    DiaChi VARCHAR(200),
    ImgUrl VARCHAR(200),
    ChungThuc TINYINT
);
Insert into KhachHang values('seafood','abc123','Anh Vũ','vutrananh98hn@gmail.com',0343423398,'Hà Nội','chuong.png',0);

