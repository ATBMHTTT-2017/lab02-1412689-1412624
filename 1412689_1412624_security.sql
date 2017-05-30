----------------create tai khoan nhan vien-------------------
--GRANT dba, connect to USER; lenh cap quen admin--
--DROP  USER  User  CASCADE; lenh drop user neu can--
--alter session set "_oracle_script"=true;
----------Tai khoan truong du an---------------
CREATE USER TDA01 IDENTIFIED BY tda01;
CREATE USER TDA02 IDENTIFIED BY tda02;
CREATE USER TDA03 IDENTIFIED BY tda03;
CREATE USER TDA04 IDENTIFIED BY tda04;
CREATE USER TDA05 IDENTIFIED BY tda05;
----------Tai khoan truong phong------------------
CREATE USER TP01 IDENTIFIED BY tp01;
CREATE USER TP02 IDENTIFIED BY tp02;
CREATE USER TP03 IDENTIFIED BY tp03;
CREATE USER TP04 IDENTIFIED BY tp04;
CREATE USER TP05 IDENTIFIED BY tp05;
-----------Tai khoan truong chi nhanh---------------
CREATE USER TCN01 IDENTIFIED BY tcn01;
CREATE USER TCN02 IDENTIFIED BY tcn02;
CREATE USER TCN03 IDENTIFIED BY tcn03;
CREATE USER TCN04 IDENTIFIED BY tcn04;
CREATE USER TCN05 IDENTIFIED BY tcn05;
-----------Tai khoan nhan vien-----------------
CREATE USER NV01 IDENTIFIED BY nv01;
CREATE USER NV02 IDENTIFIED BY nv02;
CREATE USER NV03 IDENTIFIED BY nv03;
CREATE USER NV04 IDENTIFIED BY nv04;
CREATE USER NV05 IDENTIFIED BY nv05;
-----------Tai khoan giam doc-------------------
CREATE USER GD01 IDENTIFIED BY gd01;
CREATE USER GD02 IDENTIFIED BY gd02;
CREATE USER GD03 IDENTIFIED BY gd03;
CREATE USER GD04 IDENTIFIED BY gd04;
CREATE USER GD05 IDENTIFIED BY gd05;


-- Tao cac role
CREATE ROLE rGiamDoc;
CREATE ROLE rTruongDuAn;
CREATE ROLE rTruongPhong;
CREATE ROLE rTruongChiNhanh;
CREATE ROLE rNhanVien;
-- Gán quyền kết nối cho tất cả user
GRANT CREATE SESSION TO PUBLIC;

--DAC Truong Phong 
--Gan quyen update va them thong tin vao Du An cho role truong phong
GRANT SELECT, INSERT, UPDATE ON DuAn TO rTruongPhong;
--Gan role cho cac user truong phong
GRANT rTruongPhong TO TP01, TP02, TP03, TP04, TP05;
--Tao ket noi cac truong phong
GRANT CREATE SESSION TO TP01, TP02, TP03, TP04, TP05;


-- DAC Giam doc duoc phep xem thong tin cac du an
-- Tao views cho Giam Doc
CREATE VIEW vGiamDoc 
AS 
SELECT DA.maDA, DA.tenDA, DA.kinhPhi, PB.tenPhong, CN.tenCN, NV.hoTen TruongDuAn, SUM(CT.soTien)TongChi FROM DuAn DA 
JOIN PhongBan PB ON PB.maPhong = DA.phongChuTri
JOIN NhanVien NV ON NV.maNV = DA.TRUONGDA
JOIN ChiNhanh CN ON CN.maCN = PB.ChiNhanh
JOIN ChiTieu CT ON CT.duAn = DA.maDA
GROUP BY  DA.maDA, DA.tenDA, DA.kinhPhi, PB.tenPhong, CN.tenCN, NV.hoTen;
-- Gan quyen xem vGiamDoc vao role rGiamDoc
GRANT SELECT ON vGiamDoc to rGiamDoc;
-- Gan role rGiamDoc cho cac user GiamDoc
GRANT rGiamDoc to GD01,GD02, GD03, GD04, GD05;
-- tao ket noi cho cac Giam Doc
GRANT CREATE SESSION TO GD01,GD02, GD03, GD04, GD05;



-- OLS
alter user lbacsys IDENTIFIED BY lbacsys ACCOUNT UNLOCK;
-- tao user dbo_sec chiu trach nhiem quan ly nhung user nao duoc phep truy xuat du lieu trong chema dbo
GRANT connect, create user, drop user,
create role, drop any role
to dbo_sec IDENTIFIED BY dbosec;
-- tạo user sec_admin chịu trách nhiệm quản lý chính sách bảo mật đành cho dữ liệu trong dbo
GRANT connect TO sec_admin IDENTIFIED BY secadmin;
-- Tạo ra các user là nhân viên trong công ty và role cho các nhân viên:


-- Ta dùng procedure SA_SYSDBA.CREATE_POLICY để tạo ra chính sách mới (bước 1 trong quy trình hiện thực OLS). 
--Quyền thực thi thủ tục này được cấp mặc định cho LBACSYS.
-- tạo ra một chính sách dùng để điều khiển các truy xuất đến bảng DuAn của dbo với tên gọi là “ACCESS_DUAN” và có cột chứa nhãn tên là “OLS_COLUMN”.
CONN lbacsys/lbacsys;
begin
SA_SYSDBA.CREATE_POLICY(
    policy_name => 'ACCESS_DUAN',
    column_name =>'OLS_COLUMN');
)
end;



--- sec_admin sẽ là user chịu trách nhiệm quản lý chính sách, duy trì hoạt động của nó
-- dbo_sec sẽ quyết định quyền truy xuất dữ liệu trong schema dbo của các user khác dựa trên mức độ tin cậy của họ


-- cấp cho user sec_admin role quản trị và các quyền thực thi trên các package liên quan:
CONN lbacsys/lbacsys;
GRANT access_duan_dba TO sec_admin;
-- Package dùng để tạo ra các thành phần của nhãn
GRANT execute ON sa_components TO sec_admin;
-- Package dùng để tạo các nhãn
GRANT execute ON sa_label_admin TO sec_admin;
-- Package dùng để gán chính sách cho các table/schema
GRANT execute ON sa_policy_admin TO sec_admin;

-- Để dbo_SEC có thể quản lý việc truy xuất của các user, 
-- ta cũng cần cấp cho user này role quản trị của chính sách và 
-- các quyền thực thi trên các package liên quan:
CONN lbacsys/lbacsys;
GRANT access_duan_dba TO dbo_sec;
-- Package dùng để gán các label cho user
GRANT execute ON sa_user_admin TO dbo_sec;


------------ tạo level

CONN sec_admin/secadmin;
BEGIN
sa_components.create_level (
policy_name => 'ACCESS_DUAN', 
long_name => 'ThongThuong', 
short_name => 'TT',
level_num => 1000);
END;
/
EXECUTE sa_components.create_level ('ACCESS_DUAN',2000,'GH','GioiHan'); 
EXECUTE sa_components.create_level ('ACCESS_DUAN',3000,'BM','BiMat');
EXECUTE sa_components.create_level ('ACCESS_DUAN',4000,'BMC','BiMatCao');
-- Tạo compartment
CONN sec_admin/secadmin;
BEGIN
sa_components.create_compartment
(policy_name => 'ACCESS_DUAN',
long_name => 'NhanSu',
short_name => 'NS',
comp_num => 2000);
END;
/
EXECUTE sa_components.create_compartment ('ACCESS_DUAN',3000,'KT','KeToan');
EXECUTE sa_components.create_compartment ('ACCESS_DUAN',1000,'KH','KeHoach');

-- Tạo group
CONN sec_admin/secadmin;
BEGIN
sa_components.create_group
(policy_name => 'ACCESS_DUAN',
long_name => 'TongCongTy',
short_name => 'TCT',
group_num => 10,
parent_name => NULL);
END;
/
EXECUTE sa_components.create_group ('ACCESS_DUAN',30,'HCM','Ho Chi Minh','TCT');
EXECUTE sa_components.create_group ('ACCESS_DUAN',50,'HN','Ha Noi','TCT');
EXECUTE sa_components.create_group ('ACCESS_DUAN',70,'DN','Da Nang','TCT');


-- Tạo nhãn dữ liệu
CONN sec_admin/secadmin;
BEGIN
sa_label_admin.create_label
(policy_name => 'ACCESS_DUAN',
label_tag => 10000,
label_value => 'TT');
END;
/
EXECUTE sa_label_admin.create_label ('ACCESS_DUAN',20000,'GH');

--------------------------------------------


--  Trưởng chi nhánh được phép truy xuất tất cả dữ liệu chi tiêu của dự án của tất cả các phòng ban thuộc quyền quản lý của mình. 
--
-- CN01','Ho Chi Minh','TCN01'
-- CN02','Ha Noi','TCN02'
-- CN04,'Da Nang','TCN04'

-- Gán nhãn cho truong chi nhanh Ho Chi Minh và Da Nang
CONN dbo_sec/dbosec;
BEGIN
sa_user_admin.set_levels
(policy_name => 'ACCESS_DUAN',
user_name => 'TCN01, TCN04',
max_level => 'GH',
min_level => 'TT',
def_level => 'GH',
row_level => 'GH');
END;
/
-- gán compartment
CONN dbo_sec/dbosec;
BEGIN
sa_user_admin.set_compartments
(policy_name => 'ACCESS_DUAN',
user_name => 'TCN01, TCN04',
read_comps => 'SM,HR',
write_comps => 'SM',
def_comps => 'SM',
row_comps => 'SM');
END;
/

-- gán group
CONN dbo_sec/dbosec;
BEGIN
sa_user_admin.set_groups
(policy_name => 'ACCESS_DUAN',
user_name => 'TCN01, TCN04',
read_groups => 'HCM,DN',
write_groups => 'HCM',
def_groups => 'HCM',
row_groups => 'HCM');
END;
/






