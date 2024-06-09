1. Lấy ra các thông tin gồm Mã hoá đơn, ngày lập hoá đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại.
SELECT MaHD, Ngay, TenKH, DiaChi, DT FROM HOADON, KHACHHANG
where HOADON.MaKH = KHACHHANG.MaKH 

2. Lấy ra các thông tin gồm Mã hoá đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại của ngày 25/5/2000.
SELECT MaHD, Ngay, TenKH, DiaChi, DT FROM HOADON, KHACHHANG
where HOADON.MaKH = KHACHHANG.MaKH and day(Ngay) = 25 and month(Ngay) = 5 and year(Ngay) = 2000

3. Lấy ra các thông tin gồm Mã hoá đơn, ngày lập hoá đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại của những hoá đơn trong tháng 6/2000.
SELECT MaHD, Ngay, TenKH, DiaChi, DT FROM HOADON, KHACHHANG
where HOADON.MaKH = KHACHHANG.MaKH and month(Ngay) = 6 and year(Ngay) = 2000

4. Lấy ra danh sách những khách hàng (tên khách hàng, địa chỉ, số điện thoại) đã mua hàng trong tháng 6/2000.
SELECT TenKH, DiaChi, DT FROM HOADON, KHACHHANG
where HOADON.MaKH = KHACHHANG.MaKH and month(Ngay) = 6 and year(Ngay) = 2000

5. Lấy ra danh sách các mặt hàng được bán từ ngày 1/1/2000 đến ngày 1/7/2000. Thông tin gồm: mã vật tư, tên vật tư.
select vt.* from HOADON as hd, CHITIETHOADON as cthd, VATTU as vt
where hd.MaHD = cthd.MaHD and vt.MaVT = cthd.MaVT and (hd.Ngay between '1/1/2000' and '1/7/2000')

6. Lấy ra danh sách các vật tư được bán từ ngày 1/1/2000 đến ngày 1/7/2000. Thông tin gồm: mã vật tư, tên vật tư, tên khách  hàng đã mua, ngày mua, số lượng mua.
select vt.MaVT, vt.TenVT, kh.tenKH, hd.Ngay, cthd.SL
from HOADON as hd, CHITIETHOADON as cthd, VATTU as vt, KHACHHANG as kh
where hd.MaHD = cthd.MaHD and vt.MaVT = cthd.MaVT and kh.MaKH = hd.MaKH
and (hd.Ngay between '1/1/2000' and '1/7/2000')

7. Lấy ra danh sách các vật tư được mua bởi những khách hàng ở Tân Bình, trong năm 2000. Thông tin lấy ra gồm: mã vật tư, tên vật tư, tên khách hàng, ngày mua, số lượng mua.
select vt.MaVT, vt.TenVT, kh.tenKH, hd.Ngay, cthd.SL
from HOADON as hd, CHITIETHOADON as cthd, VATTU as vt, KHACHHANG as kh
where hd.MaHD = cthd.MaHD and vt.MaVT = cthd.MaVT and kh.MaKH = hd.MaKH
and year(hd.Ngay) = 2000 and kh.DiaChi like '%Tan Binh%'

8. Lấy ra danh sách các vật tư được mua bởi những khách hàng ở Tân Bình, trong năm 2000. Thông tin lấy ra gồm: mã vật tư, tên vật tư.
select vt.MaVT, vt.TenVT
from HOADON as hd, CHITIETHOADON as cthd, VATTU as vt, KHACHHANG as kh
where hd.MaHD = cthd.MaHD and vt.MaVT = cthd.MaVT and kh.MaKH = hd.MaKH
and year(hd.Ngay) = 2000 and kh.DiaChi like '%Tan Binh%'
group by vt.MaVT, vt.TenVT


9. Lấy ra danh sách những khách hàng không mua hàng trong tháng 6/2000 gồm các thông tin tên khách hàng, địa chỉ, số điện thoại.
select kh.* from HOADON as hd, KHACHHANG as kh
where hd.MaKH = kh.MaKH
		and not(month(hd.Ngay) = 6)