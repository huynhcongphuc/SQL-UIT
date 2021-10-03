--BÀI TẬP 1
USE QLBHANG
set Dateformat DMY

--Câu 12
select SOHD from CTHD
where ((MASP = 'BB01') or (MASP = 'BB02') and SL between 10 and 20) 

--Câu 13
select SOHD from CTHD
where (MASP = 'BB01' and SL between 10 and 20) and SOHD in (select SOHD from CTHD where (MASP = 'BB02'and SL between 10 and 20))

--BÀI TẬP 4

--Câu 14
select MASP, TENSP from SANPHAM
where NUOCSX = 'Trung Quoc' 
or MASP in ( select MASP from CTHD where SOHD in
(select SOHD from HOADON where NGHD = '01/01/2007'))

--Câu 15
select MASP, TENSP from SANPHAM
where MASP not in ( select MASP from CTHD )

--Câu 16
select MASP, TENSP from SANPHAM
where MASP not in ( select MASP from CTHD where SOHD in
(select SOHD from HOADON where YEAR(NGHD) = 2006))

--Câu 17
select MASP, TENSP from SANPHAM
where NUOCSX = 'Trung Quoc' and MASP not in ( select MASP from CTHD where SOHD in
(select SOHD from HOADON where YEAR(NGHD) = 2006))

--Cau 18

select R1.SOHD from HOADON R1 -- KQ(SOHD)
where year(NGHD) = 2006 and not exists (
	select * from SANPHAM S -- Số chia SANPHAM(MASP)
	where S.NUOCSX = 'Singapore' and not exists (
		select * from CTHD R2 -- Số bị chia CTHD(MASP,SOHD)
		where R1.SOHD = R2.SOHD and R2.MASP = S.MASP))


--BÀI TẬP 2
USE QLHVU
set Dateformat DMY

-- Câu 1
update GIAOVIEN
set HESO = HESO + 0.2 where MAGV in (select MAGV from KHOA where TRGKHOA = MAGV)

-- Câu 2
UPDATE HocVien
SET DiemTB =
(
	select AVG(Final.DIEM) from (SELECT KQ.MAHV, KQ.MAMH, KQ.LANTHI, KQ.DIEM from KETQUATHI KQ
	inner join 
	(select MAHV,MAMH,MAX(LANTHI) AS LANTHI FROM KetQuaThi group by MAHV, MAMH) KQ2 
	on KQ.MAHV = KQ2.MAHV and KQ.MAMH = KQ2.MAMH and KQ.LANTHI = KQ2.LANTHI) Final
	group by Final.MAHV
	having Final.MAHV = HocVien.MaHV
)

-- Câu 3
update HOCVIEN
set GHICHU = 'Cam thi' where MAHV in 
(select MAHV from KETQUATHI where LANTHI =3 and DIEM < 5)

-- Câu 4
UPDATE HOCVIEN
SET XEPLOAI =
(
	CASE 
		WHEN DIEMTB >= 9 THEN 'XS'
		WHEN DIEMTB >= 8 AND DIEMTB < 9 THEN 'G'
		WHEN DIEMTB >= 6.5 AND DIEMTB < 8 THEN 'K'
		WHEN DIEMTB >= 5 AND DIEMTB < 6.5 THEN 'TB'
		WHEN DIEMTB < 5 THEN 'Y'
	END
)

-- BÀI TẬP 3

-- Câu 6
select MAMH, TENMH from MONHOC where MAMH in (
select MAMH from GIANGDAY 
where HOCKY = 1 and NAM = 2006
and MAGV = (select MAGV from GIAOVIEN
where HOTEN = 'Tran Tam Thanh'))

-- Câu 7
select MAMH, TENMH from MONHOC where MAMH in (
select MAMH from GIANGDAY 
where HOCKY = 1 and NAM = 2006
and MAGV in (select MAGVCN from LOP where MALOP = 'K11'))

-- Câu 8
select HO, TEN from HOCVIEN
where MAHV in (select TRGLOP from LOP where MAGVCN = (
select MAGV from GIAOVIEN
where HOTEN = 'Nguyen To Lan' and MAGV in
(select MAGV from GIANGDAY where MAMH = 
(select MAMH from MONHOC where TENMH = 'Co So Du Lieu'))))

-- Câu 9
select MAMH, TENMH from MONHOC
where MAMH in (select MAMH_TRUOC from DIEUKIEN 
where MAMH = (select MAMH from MONHOC 
where TENMH ='Co So Du Lieu'))

-- Câu 10
select MAMH, TENMH from MONHOC
where MAMH in (select MAMH from DIEUKIEN 
where MAMH_TRUOC = (select MAMH from MONHOC 
where TENMH ='Cau Truc Roi Rac'))

-- BÀI TẬP 5

-- Câu 11
select HOTEN from GIAOVIEN
where MAGV in (select MAGV from GIANGDAY where MAMH = 'CTRR' and 
(MALOP = 'K11' or MALOP = 'K12') and HOCKY = 1 and NAM = 2006)

-- Câu 12
select HO, TEN from HOCVIEN
where MAHV in (select KQ.MAHV from KETQUATHI KQ
where KQ.LANTHI = 1 and KQ.KQUA = 'Khong Dat' and
not exists (select KQ2.MAHV from KETQUATHI KQ2
where KQ2.LANTHI = 2 and KQ.MAHV = KQ2.MAHV))

-- Câu 13
select HOTEN from GIAOVIEN
where MAGV not in (select MAGV from GIANGDAY)

-- Câu 14
select GV1.HOTEN from GIAOVIEN GV1
where GV1.MAGV not in (select MAGV from GIANGDAY
where MAMH in (select MAMH from MONHOC 
where GV1.MAKHOA = MAKHOA))

-- Câu 15
select HO, TEN from HOCVIEN
where MAHV in (select MAHV from KETQUATHI
where LANTHI = 3 and KQUA = 'Khong Dat' or
LANTHI = 2 and DIEM = 5 and MAMH = 'CTRR')

-- Câu 16
select HOTEN from GIAOVIEN
where MAGV in (select MAGV from GIANGDAY
	where MAMH = 'CTRR' 
	group by NAM, HOCKY, MAGV
	having COUNT(MALOP) >= 2)

-- Câu 17
select HO, TEN, table3.MAHV, table3.MAMH,DIEM  from HOCVIEN HV
inner join
(select KQ.MAHV, KQ.MAMH,DIEM from KETQUATHI KQ
inner join
	(select MAHV, MAMH, MAX(LANTHI) as LANTHImax from KETQUATHI
	where MAMH = 'CSDL'
	group by MAMH, MAHV) KQ2
	on KQ2.MAHV = KQ.MAHV and KQ.MAMH = KQ2.MAMH and KQ.LANTHI = KQ2.LANTHImax)
		table3 on HV.MAHV = table3.MAHV

-- Câu 18
select HO, TEN, table3.MAHV, table3.MAMH,DIEM  from HOCVIEN HV
inner join
(select KQ.MAHV, KQ.MAMH,DIEM from KETQUATHI KQ
inner join
	(select MAHV, MAMH, MAX(DIEM) as DIEMmax from KETQUATHI
	where MAMH = (select MAMH from MONHOC where TENMH = 'Co So Du Lieu')
	group by MAMH, MAHV) KQ2
	on KQ2.MAHV = KQ.MAHV and KQ.MAMH = KQ2.MAMH and KQ.DIEM = KQ2.DIEMmax)
		table3 on HV.MAHV = table3.MAHV
	

