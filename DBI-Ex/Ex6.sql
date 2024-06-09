--1. Xoá dữ liệu khách hàng có mã KH02
select * from KHACHHANG
delete from CHITIETHOADON where MaHD='HD002'
delete from HOADON where MaKH = 'KH02'
delete from KHACHHANG where MaKH = 'KH02'
select * from KHACHHANG
select * from HOADON
select * from CHITIETHOADON
select * from VATTU

--2. Xoá tất cả khách hàng ở quận TAN BINH

delete from CHITIETHOADON where MaHD='HD001'
delete from CHITIETHOADON where MaHD='HD003'
delete from CHITIETHOADON where MaHD='HD006'
delete from CHITIETHOADON where MaHD='HD011'
delete from CHITIETHOADON where MaHD='HD008'
delete from CHITIETHOADON where MaHD='HD010'
delete from CHITIETHOADON where MaHD='HD012'

delete from HOADON where MaKH = 'KH01'
delete from HOADON where MaKH = 'KH03'
delete from HOADON where MaKH = 'KH06'

delete from KHACHHANG
where DiaChi='TAN BINH'
--3. Xóa tất cả vật tư có giá mua < 1000
select * from VATTU
select * from CHITIETHOADON

delete from CHITIETHOADON where MaVT='VT03'
delete from CHITIETHOADON where MaVT='VT04'

delete from VATTU where GiaMua < 1000

--4. Cập nhật giá bán vật tư có mã VT05 tăng thêm 10%
select * from CHITIETHOADON
update CHITIETHOADON
set GiaBan = GiaBan*1.1
where MaVT = 'VT05'
select * from CHITIETHOADON

--5. Cập nhật giá bán của tất cả các vật tư trong mục chi tiết hoá đơn tăng thêm 10% của hoá đơn HD001
begin transaction ABC
delete from CHITIETHOADON where MaVT = 'VT01'
select * from CHITIETHOADON
rollback transaction ABC

select * from CHITIETHOADON