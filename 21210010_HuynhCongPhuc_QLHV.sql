--BANG QUAN LY GIAO VU
--LAB 1.1
--BAI TAP 1
--CAU 1
CREATE DATABASE QLHVU

USE QLHVU

CREATE TABLE LOP
(
	MALOP char(3) PRIMARY KEY,
	TENLOP varchar(40),
	TRGLOP char(5),
	SISO tinyint,
	MAGVCN char(4)
)

CREATE TABLE HOCVIEN
(
	MAHV char(5) PRIMARY KEY,
	HO varchar(40),
	TEN	varchar(10),
	NGSINH smalldatetime,
	GIOITINH varchar(3),
	NOISINH varchar(40),
	MALOP char(3) FOREIGN KEY REFERENCES LOP
)

ALTER TABLE HOCVIEN
ADD GHICHU varchar(100) , DIEMTB numeric(4,2), XEPLOAI varchar(10)

CREATE TABLE KHOA
(
	MAKHOA varchar(4) PRIMARY KEY,
	TENKHOA varchar(40),
	NGTLAP smalldatetime,
	TRGKHOA char(4)
)

CREATE TABLE GIAOVIEN
(
	MAGV char(4) PRIMARY KEY,
	HOTEN varchar(40),
	HOCVI varchar(10),
	HOCHAM varchar(10),
	GIOITINH varchar(3),
	NGSINH smalldatetime,
	NGVL smalldatetime,
	HESO numeric(4,2),
	MUCLUONG money,
	MAKHOA varchar(4) FOREIGN KEY REFERENCES KHOA
)

ALTER TABLE KHOA
ADD FOREIGN KEY (TRGKHOA) REFERENCES GIAOVIEN

CREATE TABLE MONHOC
(
	MAMH varchar(10) PRIMARY KEY,
	TENMH varchar(40),
	TCLT tinyint,
	TCTH tinyint,
	MAKHOA varchar(4) FOREIGN KEY REFERENCES KHOA
)

CREATE TABLE DIEUKIEN
(
	MAMH varchar(10) FOREIGN KEY REFERENCES MONHOC,
	MAMH_TRUOC varchar(10),
	PRIMARY KEY(MAMH, MAMH_TRUOC)
)

CREATE TABLE GIANGDAY
(
	MALOP char(3) FOREIGN KEY REFERENCES LOP,
	MAMH varchar(10) FOREIGN KEY REFERENCES MONHOC,
	MAGV char(4) FOREIGN KEY REFERENCES GIAOVIEN,
	HOCKY tinyint,
	NAM smallint,
	TUNGAY smalldatetime,
	DENNGAY smalldatetime,
	PRIMARY KEY(MALOP, MAMH)
)

CREATE TABLE KETQUATHI
(
	MAHV char(5)  FOREIGN KEY REFERENCES HOCVIEN,
	MAMH varchar(10) FOREIGN KEY REFERENCES MONHOC,
	LANTHI tinyint,
	NGTHI smalldatetime,
	DIEM numeric(4,2),
	KQUA varchar(10),
	PRIMARY KEY(MAHV, MAMH, LANTHI)
)

-----------------------------------------------------------------------------------------------------------------------------
--BAI TAP 3
--CAU 3
ALTER TABLE HOCVIEN
ADD CHECK (GIOITINH IN ('Nam', 'Nu'))

ALTER TABLE GIAOVIEN
ADD CHECK (GIOITINH IN ('Nam', 'Nu'))

--CAU 4
ALTER TABLE KETQUATHI
ADD CHECK ((DIEM >=0) AND (DIEM <= 10))


--CAU 5
ALTER TABLE KETQUATHI
ADD CHECK (((DIEM >=5) AND (KQUA = 'Dat')) OR ((DIEM <5) AND (KQUA = 'Khong dat')))

--CAU 6
ALTER TABLE KETQUATHI
ADD CHECK (LANTHI <= 3)

--CAU 7
ALTER TABLE GIANGDAY
ADD CHECK (HOCKY >= 1 AND HOCKY <=3)

--CAU 8
ALTER TABLE GIAOVIEN
ADD CHECK (HOCVI IN ('CN', 'KS', 'Ths', 'TS', 'PTS'))

-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
--LAB 1.2
--BAI TAP 2
SET DATEFORMAT DMY

INSERT INTO LOP (MALOP,TENLOP,TRGLOP,SISO,MAGVCN)
VALUES
('K11','Lop 1 khoa 1','K1108',11,'GV07'),
('K12','Lop 2 khoa 1','K1205',12,'GV09'),
('K13','Lop 3 khoa 1','K1305',12,'GV14')


INSERT INTO HOCVIEN (MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP)
VALUES
('K1101','Nguyen Van','A','27/1/1986','Nam','TpHCM','K11'),
('K1102','Tran Ngoc','Han','14/3/1986','Nu','Kien Giang','K11'),
('K1103','Ha Duy','Lap','18/4/1986','Nam','Nghe An','K11'),
('K1104','Tran Ngoc','Linh','30/3/1986','Nu','Tay Ninh','K11'),
('K1105','Tran Minh','Long','27/2/1986','Nam','TpHCM','K11'),
('K1106','Le Nhat','Minh','24/1/1986','Nam','TpHCM','K11'),
('K1107','Nguyen Nhu','Nhut','27/1/1986','Nam','Ha Noi','K11'),
('K1108','Nguyen Manh','Tam','27/2/1986','Nam','Kien Giang','K11'),
('K1109','Phan Thi Thanh','Tam','27/1/1986','Nu','Vinh Long','K11'),
('K1110','Le Hoai','Thuong','5/2/1986','Nu','Can Tho','K11'),
('K1111','Le Ha','Vinh','25/12/1986','Nam','Vinh Long','K11'),
('K1201','Nguyen Van','B','11/2/1986','Nam','TpHCM','K12'),
('K1202','Nguyen Thi Kim','Duyen','18/1/1986','Nu','TpHCM','K12'),
('K1203','Tran Thi Kim','Duyen','17/9/1986','Nu','TpHCM','K12'),
('K1204','Truong My','Hanh','19/5/1986','Nu','Dong Nai','K12'),
('K1205','Nguyen Thanh','Nam','17/4/1986','Nam','TpHCM','K12'),
('K1206','Nguyen Thi Truc','Thanh','4/3/1986','Nu','Kien Giang','K12'),
('K1207','Tran Thi Bich','Thuy','8/2/1986','Nu','Nghe An','K12'),
('K1208','Huynh Thi Kim','Trieu','8/4/1986','Nu','Tay Ninh','K12'),
('K1209','Pham Thanh','Trieu','23/2/1986','Nam','TpHCM','K12'),
('K1210','Ngo Thanh','Tuan','14/2/1986','Nam','TpHCM','K12'),
('K1211','Do Thi','Xuan','9/3/1986','Nu','Ha Noi','K12'),
('K1212','Le Thi Phi','Yen','12/3/1986','Nu','TpHCM','K12'),
('K1301','Nguyen Thi Kim','Cuc','9/6/1986','Nu','Kien Giang','K13'),
('K1302','Truong Thi My','Hien','18/3/1986','Nu','Nghe An','K13'),
('K1303','Le Duc','Hien','21/3/1986','Nam','Tay Ninh','K13'),
('K1304','Le Quang','Hien','18/4/1986','Nam','TpHCM','K13'),
('K1305','Le Thi','Huong','27/3/1986','Nu','TpHCM','K13'),
('K1306','Nguyen Thai','Huu','30/3/1986','Nam','Ha Noi','K13'),
('K1307','Tran Minh','Man','28/5/1986','Nam','TpHCM','K13'),
('K1308','Nguyen Hieu','Nghia','8/4/1986','Nam','Kien Giang','K13'),
('K1309','Nguyen Trung','Nghia','18/1/1987','Nam','Nghe An','K13'),
('K1310','Tran Thi Hong','Tham','22/4/1986','Nu','Tay Ninh','K13'),
('K1311','Tran Minh','Thuc','4/4/1986','Nam','TpHCM','K13'),
('K1312','Nguyen Thi Kim','Yen','7/9/1986','Nu','TpHCM','K13')

INSERT INTO KHOA(MAKHOA,TENKHOA,NGTLAP)
VALUES
('KHMT','Khoa hoc may tinh','7/6/2005'),
('HTTT','He thong thong tin','7/6/2005'),
('CNPM','Cong nghe phan mem','7/6/2005'),
('MTT','Mang va truyen thong','20/10/2005'),
('KTMT','Ky thuat may tinh','20/12/2005')

INSERT INTO GIAOVIEN(MAGV,HOTEN,HOCVI,HOCHAM,GIOITINH,NGSINH,NGVL,HESO,MUCLUONG,MAKHOA)
VALUES
('GV01','Ho Thanh Son','PTS','GS','Nam','2/5/1950','11/1/2004',5,2250000,'KHMT'),
('GV02','Tran Tam Thanh','TS','PGS','Nam','17/12/1965','20/4/2004',4.5,2025000,'HTTT'),
('GV03','Do Nghiem Phung','TS','GS','Nu','1/8/1950','23/9/2004',4,1800000,'CNPM'),
('GV04','Tran Nam Son','TS','PGS','Nam','22/2/1961','12/1/2005',4.5,2025000,'KTMT'),
('GV05','Mai Thanh Danh','ThS','GV','Nam','12/3/1958','12/1/2005',3,1350000,'HTTT'),
('GV06','Tran Doan Hung','TS','GV','Nam','11/3/1953','12/1/2005',4.5,2025000,'KHMT'),
('GV07','Nguyen Minh Tien','ThS','GV','Nam','23/11/1971','1/3/2005',4,1800000,'KHMT'),
('GV08','Le Thi Tran','KS','Null','Nu','26/3/1974','1/3/2005',1.69,760500,'KHMT'),
('GV09','Nguyen To Lan','ThS','GV','Nu','31/12/1966','1/3/2005',4,1800000,'HTTT'),
('GV10','Le Tran Anh Loan','KS','Null','Nu','17/7/1972','1/3/2005',1.86,837000,'CNPM'),
('GV11','Ho Thanh Tung','CN','GV','Nam','12/1/1980','15/5/2005',2.67,1201500,'MTT'),
('GV12','Tran Van Anh','CN','Null','Nu','29/3/1981','15/5/2005',1.69,760500,'CNPM'),
('GV13','Nguyen Linh Dan','CN','Null','Nu','23/5/1980','15/5/2005',1.69,760500,'KTMT'),
('GV14','Truong Minh Chau','ThS','GV','Nu','30/11/1976','15/5/2005',3,1350000,'MTT'),
('GV15','Le Ha Thanh','ThS','GV','Nam','4/5/1978','15/5/2005',3,1350000,'KHMT')

UPDATE KHOA
SET TRGKHOA = 'GV01' WHERE MAKHOA = 'KHMT'
UPDATE KHOA
SET TRGKHOA = 'GV02' WHERE MAKHOA = 'HTTT'
UPDATE KHOA
SET TRGKHOA = 'GV04' WHERE MAKHOA = 'CNPM'
UPDATE KHOA
SET TRGKHOA = 'GV03' WHERE MAKHOA = 'MTT'

INSERT INTO MONHOC(MAMH,TENMH,TCLT,TCTH,MAKHOA)
VALUES
('THDC','Tin hoc dai cuong',4,1,'KHMT'),
('CTRR','Cau truc roi rac',5,2,'KHMT'),
('CSDL','Co so du lieu',3,1,'HTTT'),
('CTDLGT','Cau truc du lieu va giai thuat',3,1,'KHMT'),
('PTTKTT','Phan tich thiet ke thuat toan',3,0,'KHMT'),
('DHMT','Do hoa may tinh',3,1,'KHMT'),
('KTMT','Kien truc may tinh',3,0,'KTMT'),
('TKCSDL','Thiet ke co so du lieu',3,1,'HTTT'),
('PTTKHTTT','Phan tich thiet ke he thong thong tin',4,1,'HTTT'),
('HDH','He dieu hanh',4,1,'KTMT'),
('NMCNPM','Nhap mon cong nghe phan mem',3,0,'CNPM'),
('LTCFW','Lap trinh C for win',3,1,'CNPM'),
('LTHDT','Lap trinh huong doi tuong',3,1,'CNPM')

SET DATEFORMAT DMY

INSERT INTO GIANGDAY(MALOP,MAMH,MAGV,HOCKY,NAM,TUNGAY,DENNGAY)
VALUES
('K11','THDC','GV07',1,2006,'2/1/2006','12/5/2006'),
('K12','THDC','GV06',1,2006,'2/1/2006','12/5/2006'),
('K13','THDC','GV15',1,2006,'2/1/2006','12/5/2006'),
('K11','CTRR','GV02',1,2006,'9/1/2006','17/5/2006'),
('K12','CTRR','GV02',1,2006,'9/1/2006','17/5/2006'),
('K13','CTRR','GV08',1,2006,'9/1/2006','17/5/2006'),
('K11','CSDL','GV05',2,2006,'1/6/2006','15/7/2006'),
('K12','CSDL','GV09',2,2006,'1/6/2006','15/7/2006'),
('K13','CTDLGT','GV15',2,2006,'1/6/2006','15/7/2006'),
('K13','CSDL','GV05',3,2006,'1/8/2006','15/12/2006'),
('K13','DHMT','GV07',3,2006,'1/8/2006','15/12/2006'),
('K11','CTDLGT','GV15',3,2006,'1/8/2006','15/12/2006'),
('K12','CTDLGT','GV15',3,2006,'1/8/2006','15/12/2006'),
('K11','HDH','GV04',1,2007,'2/1/2007','18/2/2007'),
('K12','HDH','GV04',1,2007,'2/1/2007','20/3/2007'),
('K11','DHMT','GV07',1,2007,'18/2/2007','20/3/2007')

INSERT INTO DIEUKIEN(MAMH,MAMH_TRUOC)
VALUES
('CSDL','CTRR'),
('CSDL','CTDLGT'),
('CTDLGT','THDC'),
('PTTKTT','THDC'),
('PTTKTT','CTDLGT'),
('DHMT','THDC'),
('LTHDT','THDC'),
('PTTKHTTT','CSDL')

INSERT INTO KETQUATHI(MAHV,MAMH,LANTHI,NGTHI,DIEM,KQUA)
VALUES
('K1101','CSDL',1,'20/7/2006',10,'Dat'),
('K1101','CTDLGT',1,'28/12/2006',9,'Dat'),
('K1101','THDC',1,'20/5/2006',9,'Dat'),
('K1101','CTRR',1,'13/5/2006',9.5,'Dat'),
('K1102','CSDL',1,'20/7/2006',4,'Khong Dat'),
('K1102','CSDL',2,'27/7/2006',4.25,'Khong Dat'),
('K1102','CSDL',3,'10/8/2006',4.5,'Khong Dat'),
('K1102','CTDLGT',1,'28/12/2006',4.5,'Khong Dat'),
('K1102','CTDLGT',2,'5/1/2007',4,'Khong Dat'),
('K1102','CTDLGT',3,'15/1/2007',6,'Dat'),
('K1102','THDC',1,'20/5/2006',5,'Dat'),
('K1102','CTRR',1,'13/5/2006',7,'Dat'),
('K1103','CSDL',1,'20/7/2006',3.5,'Khong Dat'),
('K1103','CSDL',2,'27/7/2006',8.25,'Dat'),
('K1103','CTDLGT',1,'28/12/2006',7,'Dat'),
('K1103','THDC',1,'20/5/2006',8,'Dat'),
('K1103','CTRR',1,'13/5/2006',6.5,'Dat'),
('K1104','CSDL',1,'20/7/2006',3.75,'Khong Dat'),
('K1104','CTDLGT',1,'28/12/2006',4,'Khong Dat'),
('K1104','THDC',1,'20/5/2006',4,'Khong Dat'),
('K1104','CTRR',1,'13/5/2006',4,'Khong Dat'),
('K1104','CTRR',2,'20/5/2006',3.5,'Khong Dat'),
('K1104','CTRR',3,'30/6/2006',4,'Khong Dat'),
('K1201','CSDL',1,'20/7/2006',6,'Dat'),
('K1201','CTDLGT',1,'28/12/2006',5,'Dat'),
('K1201','THDC',1,'20/5/2006',8.5,'Dat'),
('K1201','CTRR',1,'13/5/2006',9,'Dat'),
('K1202','CSDL',1,'20/7/2006',8,'Dat'),
('K1202','CTDLGT',1,'28/12/2006',4,'Khong Dat'),
('K1202','CTDLGT',2,'5/1/2007',5,'Dat'),
('K1202','THDC',1,'20/5/2006',4,'Khong Dat'),
('K1202','THDC',2,'27/5/2006',4,'Khong Dat'),
('K1202','CTRR',1,'13/5/2006',3,'Khong Dat'),
('K1202','CTRR',2,'20/5/2006',4,'Khong Dat'),
('K1202','CTRR',3,'30/6/2006',6.25,'Dat'),
('K1203','CSDL',1,'20/7/2006',9.25,'Dat'),
('K1203','CTDLGT',1,'28/12/2006',9.5,'Dat'),
('K1203','THDC',1,'20/5/2006',10,'Dat'),
('K1203','CTRR',1,'13/5/2006',10,'Dat'),
('K1204','CSDL',1,'20/7/2006',8.5,'Dat'),
('K1204','CTDLGT',1,'28/12/2006',6.75,'Dat'),
('K1204','THDC',1,'20/5/2006',4,'Khong Dat'),
('K1204','CTRR',1,'13/5/2006',6,'Dat'),
('K1301','CSDL',1,'20/12/2006',4.25,'Khong Dat'),
('K1301','CTDLGT',1,'25/7/2006',8,'Dat'),
('K1301','THDC',1,'20/5/2006',7.75,'Dat'),
('K1301','CTRR',1,'13/5/2006',8,'Dat'),
('K1302','CSDL',1,'20/12/2006',6.75,'Dat'),
('K1302','CTDLGT',1,'25/7/2006',5,'Dat'),
('K1302','THDC',1,'20/5/2006',8,'Dat'),
('K1302','CTRR',1,'13/5/2006',8.5,'Dat'),
('K1303','CSDL',1,'20/12/2006',4,'Khong Dat'),
('K1303','CTDLGT',1,'25/7/2006',4.5,'Khong Dat'),
('K1303','CTDLGT',2,'7/8/2006',4,'Khong Dat'),
('K1303','CTDLGT',3,'15/8/2006',4.25,'Khong Dat'),
('K1303','THDC',1,'20/5/2006',4.5,'Khong Dat'),
('K1303','CTRR',1,'13/5/2006',3.25,'Khong Dat'),
('K1303','CTRR',2,'20/5/2006',5,'Dat'),
('K1304','CSDL',1,'20/12/2006',7.75,'Dat'),
('K1304','CTDLGT',1,'25/7/2006',9.75,'Dat'),
('K1304','THDC',1,'20/5/2006',5.5,'Dat'),
('K1304','CTRR',1,'13/5/2006',5,'Dat'),
('K1305','CSDL',1,'20/12/2006',9.25,'Dat'),
('K1305','CTDLGT',1,'25/7/2006',10,'Dat'),
('K1305','THDC',1,'20/5/2006',8,'Dat'),
('K1305','CTRR',1,'13/5/2006',10,'Dat')

-----------------------------------------------------------------------------------------------------------------------------
--BAI TAP 4
--PHAN 1
--CAU 11
ALTER TABLE HOCVIEN
ADD CHECK (DATEDIFF ( YEAR , NGSINH, GETDATE()) >= 18)

--CAU 12
ALTER TABLE GIANGDAY
ADD CHECK (DENNGAY > TUNGAY)

--CAU 13
ALTER TABLE GIAOVIEN
ADD CHECK (DATEDIFF ( YEAR , NGSINH, GETDATE()) >= 22)

--CAU 14
ALTER TABLE MONHOC
ADD CHECK (TCLT - TCTH <= 3)

-----------------------------------------------------------------------------------------------------------------------------
--BAI TAP 6
--PHAN 3
--CAU 1	
SELECT MAHV,HO,TEN, NGSINH, MALOP FROM HOCVIEN WHERE MAHV IN (SELECT TRGLOP FROM LOP)

--CAU 2
SELECT HOCVIEN.MAHV, HO, TEN, LANTHI, DIEM 
FROM HOCVIEN INNER JOIN KETQUATHI 
ON HOCVIEN.MAHV = KETQUATHI.MAHV 
WHERE MALOP = 'K12' AND MAMH = 'CTRR' 
ORDER BY HO ASC, TEN ASC

--CAU 3
SELECT HOCVIEN.MAHV,HO,TEN, MAMH
FROM HOCVIEN INNER JOIN KETQUATHI
ON HOCVIEN.MAHV = KETQUATHI.MAHV
WHERE LANTHI <= 1 AND KQUA = 'Dat'

--CAU 4
SELECT HOCVIEN.MAHV,HO,TEN
FROM HOCVIEN INNER JOIN KETQUATHI
ON HOCVIEN.MAHV = KETQUATHI.MAHV
WHERE MALOP = 'K11' AND LANTHI <= 1 AND KQUA = 'Khong dat' AND MAMH = 'CTRR'

--CAU 5
SELECT HOCVIEN.MAHV,HO,TEN
FROM HOCVIEN INNER JOIN KETQUATHI
ON HOCVIEN.MAHV = KETQUATHI.MAHV
WHERE MALOP LIKE 'K%' AND KQUA = 'Khong dat' AND MAMH = 'CTRR'





