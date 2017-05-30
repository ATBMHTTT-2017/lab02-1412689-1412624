------------------DROP---------------------
/*
Drop table ChiNhanh;
DROP TABLE NhanVien CASCADE CONSTRAINTS;
DROP TABLE ChiNhanh CASCADE CONSTRAINTS;
DROP TABLE PhongBan CASCADE CONSTRAINTS;
Drop table NhanVien;
Drop table PhanCong;
Drop table PhongBan;
Drop table ChiTieu;
Drop table DuAn;
*/

GRANT ALL privileges to dbo IDENTIFIED BY 123;
CONN dbo/123;
--Bang Chi Nhanh
CREATE TABLE ChiNhanh(
maCN VARCHAR2(8) NOT NULL,
tenCN VARCHAR2(50) NOT NULL,
truongChiNhanh VARCHAR2(8) NOT NULL
);

ALTER TABLE ChiNhanh
ADD CONSTRAINT PK_ChiNhanh
PRIMARY KEY(maCN);

--Bang Nhan Vien
CREATE TABLE NhanVien(
maNV VARCHAR2(8) NOT NULL,
hoTen VARCHAR2(50) NOT NULL,
diaChi VARCHAR2(100) NOT NULL,
dienThoai VARCHAR2(20),
email VARCHAR2(100),
maPhong VARCHAR2(8),
chiNhanh VARCHAR2(8),
luong RAW
);
ALTER TABLE NhanVien
ADD CONSTRAINT PK_NhanVien
PRIMARY KEY(maNV);

--Bang Phong Ban
CREATE TABLE PhongBan(
maPhong VARCHAR2(8) NOT NULL,
tenPhong VARCHAR2(50) NOT NULL,
truongPhong VARCHAR2(8) NOT NULL,
ngayNhamChuc VARCHAR2(50),
soNhanVien NUMBER,
chiNhanh VARCHAR2(8) NOT NULL
);
ALTER TABLE PhongBan
ADD CONSTRAINT PK_PhongBan
PRIMARY KEY(maPhong);

--Bang Du An
CREATE TABLE  DuAn(
maDA VARCHAR2(8) NOT NULL,
tenDA VARCHAR2(50) NOT NULL,
kinhPhi RAW,
phongChuTri VARCHAR2(8),
truongDA VARCHAR2(8)
);
ALTER TABLE DuAn
ADD CONSTRAINT PK_DuAn
PRIMARY KEY(maDA);

--B?ng Chi Tieu
CREATE TABLE ChiTieu(
maChiTieu VARCHAR2(8) NOT NULL,
tenChiTieu VARCHAR2(50) NOT NULL,
soTien RAW,
duAn VARCHAR2(8) NOT NULL
);
ALTER TABLE ChiTieu
ADD CONSTRAINT PK_ChiTieu
PRIMARY KEY(maChiTieu);

--Bang Phan Cong
CREATE TABLE PhanCong(
maNV VARCHAR2(8) NOT NULL,
duAn VARCHAR2(8) NOT NULL,
vaiTro VARCHAR2(200),
phuCap RAW
);
ALTER TABLE PhanCong
ADD CONSTRAINT PK_PhanCong
PRIMARY KEY(maNV, duan);
------------------------------------------------
--------khoa ngoai ChiNhanh
ALTER TABLE ChiNhanh
ADD CONSTRAINT FK1_ChiNhanh_NhanVien 
FOREIGN KEY(truongChiNhanh) 
REFERENCES NhanVien(maNV);

---------khoa ngoai NhanVien
ALTER TABLE NhanVien
ADD CONSTRAINT FK1_NhanVien_PhongBan 
FOREIGN KEY(maPhong) 
REFERENCES Phongban(maPhong);

ALTER TABLE NhanVien
ADD CONSTRAINT FK2_NhanVien_ChiNhanh 
FOREIGN KEY(chiNhanh) 
REFERENCES ChiNhanh(maCN);
------Khoa ngoai Phong Ban
ALTER TABLE Phongban
ADD CONSTRAINT FK1_PhongBan_ChiNhanh
FOREIGN KEY(chiNhanh) 
REFERENCES ChiNhanh(maCN);

ALTER TABLE Phongban
ADD CONSTRAINT FK2_PhongBan_NhanVien 
FOREIGN KEY(truongPhong) 
REFERENCES NhanVien(maNV);

-------Bang Du An
ALTER TABLE DuAn
ADD CONSTRAINT FK1_DuAn_NhanVien
FOREIGN KEY(truongDA) 
REFERENCES NhanVien(maNV);

ALTER TABLE DuAn
ADD CONSTRAINT FK2_DuAn_PhongBan
FOREIGN KEY(phongChuTri) 
REFERENCES Phongban(maPhong);

------Bang Chi Tieu
ALTER TABLE ChiTieu
ADD CONSTRAINT FK1_ChiTieu_DuAn 
FOREIGN KEY(duAn) 
REFERENCES DuAn(maDA);

-------Bang Phan Cong
ALTER TABLE PhanCong
ADD CONSTRAINT FK1_PhanCong_DuAn 
FOREIGN KEY(duAn) 
REFERENCES DuAn(maDA);

ALTER TABLE PhanCong
ADD CONSTRAINT FK2_PhanCong_NhanVien
FOREIGN KEY(maNV) 
REFERENCES NhanVien(maNV);

-- Them du lieu bang NhanVien
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('TDA01', 'Daphene Worthing', '86 Emmet Terrace', '86-(639)125-0808', 'dworthing0@nymag.com', null, null, 6305);
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('TDA02', 'Mathilde Hartegan', '67 Saint Paul Lane', '86-(446)994-7734', 'mhartegan1@zimbio.com', null, null, 2390);
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('TDA03', 'Jacquenetta Jenoure', '50 Service Parkway', '33-(408)147-4917', 'jjenoure2@domainmarket.com', null, null, 5761);
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('TDA04', 'Luci Hugle', '66716 Susan Center', '223-(471)206-0692', 'lhugle3@yolasite.com', null, null, 8172);
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('TDA05', 'Caritta Andrzejczak', '0251 Spohn Pass', '381-(148)634-7162', 'candrzejczak4@xinhuanet.com', null, null, 5140);
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('TP01', 'Jedidiah Collin', '4058 Briar Crest Crossing', '84-(736)260-4663', 'jcollin5@google.it', null, null, 6929);
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('TP02', 'Merry Dobel', '3534 Huxley Avenue', '62-(467)368-2912', 'mdobel6@constantcontact.com', null, null, 8502);
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('TP03', 'Annabel Dunlop', '272 Dayton Center', '380-(139)596-6700', 'adunlop7@dailymail.co.uk', null, null, 8271);
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('TP04', 'Jeanne Willder', '1 Summerview Road', '48-(297)297-5929', 'jwillder8@chronoengine.com', null, null, 5174);
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('TP05', 'Sadella Espinheira', '95 Mesta Crossing', '86-(678)641-2538', 'sespinheira9@gnu.org', null, null, 7696);
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('TCN01', 'Bradford Sinclar', '86 Mockingbird Street', '370-(404)340-4922', 'bsinclara@earthlink.net', null, null, 5289);
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('TCN02', 'Loreen Tompkiss', '234 Debs Way', '52-(670)374-1785', 'ltompkissb@mozilla.org', null, null, 7480);
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('TCN03', 'Ali Hartrick', '99 Texas Crossing', '63-(680)373-1803', 'ahartrickc@sphinn.com', null, null, 4129);
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('TCN04', 'Annabelle Gotch', '0 Donald Avenue', '994-(791)370-2532', 'agotchd@4shared.com', null, null, 2233);
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('TCN05', 'Orrin Rove', '0630 Emmet Drive', '359-(465)910-5065', 'orovee@intel.com', null, null, 8160);
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('NV01', 'Raeann Batiste', '649 Gateway Center', '62-(660)181-2441', 'rbatistef@shareasale.com', null, null, 4696);
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('NV02', 'Gisele Grice', '02286 Brentwood Road', '46-(601)343-1512', 'ggriceg@shareasale.com', null, null, 4650);
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('NV03', 'Korie Winwright', '90 Golden Leaf Trail', '86-(836)757-0878', 'kwinwrighth@liveinternet.ru', null, null, 4763);
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('NV04', 'Marylinda De Gowe', '976 Butterfield Crossing', '357-(359)754-0868', 'mdei@smh.com.au', null, null, 2507);
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('NV05', 'Elfrieda Becom', '84256 Karstens Junction', '593-(939)337-7571', 'ebecomj@goo.gl', null, null, 5452);
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('GD01', 'Sylvan Metcalfe', '32801 Dunning Center', '63-(317)423-4321', 'smetcalfek@moonfruit.com', null, null, 8876);
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('GD02', 'Paul Leuty', '5823 Buena Vista Way', '261-(441)163-5934', 'pleutyl@dyndns.org', null, null, 6864);
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('GD03', 'Harriet Bruckental', '1795 Mendota Pass', '46-(179)192-5253', 'hbruckentalm@timesonline.co.uk', null, null, 5772);
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('GD04', 'Anneliese Gittins', '02736 Texas Court', '62-(655)845-2672', 'agittinsn@feedburner.com', null, null, 3386);
INSERT INTO NhanVien (maNV, hoTen, diaChi, dienThoai, email, maPhong, chiNhanh, luong) VALUES ('GD05', 'Joel Betchley', '8 Kenwood Pass', '55-(125)758-3041', 'jbetchleyo@amazon.co.jp', null, null, 5412);
-- Them du lieu bang ChiNhanh
INSERT INTO ChiNhanh(maCN, tenCN, truongChiNhanh ) VALUES ('CN01','Ho Chi Minh','TCN01');
INSERT INTO ChiNhanh(maCN, tenCN, truongChiNhanh ) VALUES ('CN02','Ha Noi','TCN02');
INSERT INTO ChiNhanh(maCN, tenCN, truongChiNhanh ) VALUES ('CN03','Can Tho','TCN03');
INSERT INTO ChiNhanh(maCN, tenCN, truongChiNhanh ) VALUES ('CN04','Da Nang','TCN04');
INSERT INTO ChiNhanh(maCN, tenCN, truongChiNhanh ) VALUES ('CN05','Hai Phong','TCN05');
-- Them du lieu bang PhongBan
INSERT INTO PhongBan(maPhong, tenPhong, truongPhong, ngayNhamChuc, soNhanVien, chiNhanh) VALUES ('PB01','Phong Tuyen Dung','TP01','2017',50,'CN01');
INSERT INTO PhongBan(maPhong, tenPhong, truongPhong, ngayNhamChuc, soNhanVien, chiNhanh) VALUES ('PB02','Phong Gym','TP02','2017',50,'CN02');
INSERT INTO PhongBan(maPhong, tenPhong, truongPhong, ngayNhamChuc, soNhanVien, chiNhanh) VALUES ('PB03','Phong Chuyen Mon','TP03','2017',50,'CN03');
INSERT INTO PhongBan(maPhong, tenPhong, truongPhong, ngayNhamChuc, soNhanVien, chiNhanh) VALUES ('PB04','Phong Kinh Doanh','TP04','2017',50,'CN04');
INSERT INTO PhongBan(maPhong, tenPhong, truongPhong, ngayNhamChuc, soNhanVien, chiNhanh) VALUES ('PB05','Phong Nhan Su','TP05','2017',50,'CN05');
-- Them du lieu bang DuAn
INSERT INTO  DuAn(maDA , tenDA, kinhPhi , phongChuTri ,truongDA ) VALUES ('DA01','Du an 01',5000,'PB01','TDA01');
INSERT INTO  DuAn(maDA , tenDA, kinhPhi , phongChuTri ,truongDA ) VALUES ('DA02','Du an 02',5000,'PB02','TDA02');
INSERT INTO  DuAn(maDA , tenDA, kinhPhi , phongChuTri ,truongDA ) VALUES ('DA03','Du an 03',5000,'PB03','TDA03');
INSERT INTO  DuAn(maDA , tenDA, kinhPhi , phongChuTri ,truongDA ) VALUES ('DA04','Du an 04',5000,'PB04','TDA04');
INSERT INTO  DuAn(maDA , tenDA, kinhPhi , phongChuTri ,truongDA ) VALUES ('DA05','Du an 05',5000,'PB05','TDA05');
-- Them du lieu bang ChiTieu
INSERT INTO ChiTieu(maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT01','Chi tieu 01',10000,'DA01');
INSERT INTO ChiTieu(maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT02','Chi tieu 02',10000,'DA02');
INSERT INTO ChiTieu(maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT03','Chi tieu 03',10000,'DA03');
INSERT INTO ChiTieu(maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT04','Chi tieu 04',10000,'DA04');
INSERT INTO ChiTieu(maChiTieu, tenChiTieu, soTien, duAn) VALUES ('CT05','Chi tieu 05',10000,'DA05');
-- Them du lieu bang PhanCong
INSERT INTO PhanCong(maNV, duAn, vaiTro, phuCap) VALUES ('NV01','DA01','Developer',2000);
INSERT INTO PhanCong(maNV, duAn, vaiTro, phuCap) VALUES ('NV02','DA02','Developer',2000);
INSERT INTO PhanCong(maNV, duAn, vaiTro, phuCap) VALUES ('NV03','DA03','Developer',2000);
INSERT INTO PhanCong(maNV, duAn, vaiTro, phuCap) VALUES ('NV04','DA04','Developer',2000);
INSERT INTO PhanCong(maNV, duAn, vaiTro, phuCap) VALUES ('NV05','DA05','Developer',2000);
-- Cap nhat lai maPhong và chiNhanh bang NhanVien
UPDATE NhanVien SET maPhong = 'PB01', chiNhanh = 'CN01' WHERE maNV LIKE '%01';
UPDATE NhanVien SET maPhong = 'PB02', chiNhanh = 'CN02' WHERE maNV LIKE '%02';
UPDATE NhanVien SET maPhong = 'PB03', chiNhanh = 'CN03' WHERE maNV LIKE '%03';
UPDATE NhanVien SET maPhong = 'PB04', chiNhanh = 'CN04' WHERE maNV LIKE '%04';
UPDATE NhanVien SET maPhong = 'PB05', chiNhanh = 'CN05' WHERE maNV LIKE '%05';


