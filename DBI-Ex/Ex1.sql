create database QLBanhang

use QLBanhang

create table VATTU(
	MAVT nvarchar(5) primary key,
	TENVT nvarchar(30),
	DTV nvarchar(20),
	GIAMUA nvarchar,
	SLTON int
);

create table HOADON(
	MAHD nvarchar(10) primary key,
	NGAY Datetime,
	MAKH nvarchar(5),
	TONGTG money
);

create table CHITIETHOADON(
	MAHD nvarchar(10) primary key,
	MAVT nvarchar(5),
	SL int,
	GIABAN money
);

select * from KHACHHANG

select MAKH, TENKH from KHACHHANG where TENKH like N'%Linh%'

select * from KHACHHANG where MAKH='KH01'

insert into KHACHHANG
values('KH01', N'Nguyễn Hoàng Linhmot', N'18 Quốc Lộ 13', N'0341111111', N'hoanglinhmot@gmail.com') 

insert into KHACHHANG
values('KH02', N'Nguyễn Hoàng Linhhai', N'19 Quốc Lộ 13', N'0341111112', N'hoanglinhhai@gmail.com') 

insert into KHACHHANG
values('KH03', N'Nguyễn Hoàng Linhba', N'20 Quốc Lộ 13', N'0341111113', N'hoanglinhba@gmail.com') 

delete from KHACHHANG

select * from KHACHHANG

delete from KHACHHANG where MAKH='KH03'

update KHACHHANG
set DT= '1234567890'
where MAKH='KH02'


