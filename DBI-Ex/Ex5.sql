--1.    Hiển danh sách các khách hàng có điện thoại là 8457895 gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
select * from KHACHHANG where DT like '%8457895'

--2.    Hiển danh sách các vật tư là “DA” (bao gồm các loại đá) có giá mua dưới 30000 gồm mã vật tư, tên vật tư, đơn vị tính và giá mua .
select MaVT, TenVT, DTV, GiaMua from VATTU where TenVT like 'DA%' and GiaMua < 30000

--3.    Tạo query để lấy ra các thông tin gồm Mã hoá đơn, ngày lập hoá đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại, sắp xếp theo thứ tự ngày tạo hóa đơn giảm dần
select hd.MaHD, hd.Ngay, kh.TenKH, kh.DiaChi, kh.DT from HOADON hd, KHACHHANG kh where kh.MaKH = hd.MaKH order by hd.Ngay desc

--4.    Lấy ra danh sách những khách hàng mua hàng trong tháng 6/2000 gồm các thông tin tên khách hàng, địa chỉ, số điện thoại.
 select TenKH, DiaChi, DT from KHACHHANG where MaKH in
(select MaKH from HOADON where MONTH(Ngay) = 6 and YEAR(Ngay) = 2000)

--5.    Tạo query để lấy ra các chi tiết hoá đơn gồm các thông tin mã hóa đơn, ,mã vật tư, tên vật tư, giá bán, giá mua, số lượng , trị giá mua (giá mua * số lượng), trị giá bán (giá bán * số lượng), tiền lời (trị giá bán – trị giá mua) mà có giá bán lớn hơn hoặc bằng giá mua.
select hd.MaHD, cthd.MaVT, vt.TenVT, cthd.GiaBan, vt.GiaMua, cthd.SL, 
		vt.GiaMua*cthd.SL as 'Trị giá mua', cthd.GiaBan*cthd.SL as 'Trị Giá Bán', 
		case when cthd.GiaBan*cthd.SL > vt.GiaMua*cthd.SL then cthd.GiaBan*cthd.SL - vt.GiaMua*cthd.SL
			else 0
		end as 'Tiền lời'
from HOADON as hd, CHITIETHOADON as cthd, VATTU as VT
where hd.MaHD = cthd.MaHD and cthd.MaVT = vt.MaVT

--6.    Lấy ra hoá đơn có tổng trị giá nhỏ nhất trong số các hóa đơn năm 2000, gồm các thông tin: Số hoá đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hoá đơn.
select hd.MaHD, hd.Ngay, kh.TenKH, kh.DiaChi, hd.TongTG from HOADON hd, KHACHHANG kh 
where hd.MaKH = kh.MaKH and TongTG <= All (
select min(TongTG) from HOADON where Year(Ngay) = 2000)

--7.    Lấy ra các thông tin về các khách hàng mua ít loại vật tư nhất.
select * from KHACHHANG where MaKH in (
select hd.MaKH from HOADON hd, CHITIETHOADON ct
where hd.MaHD = ct.MaHD
group by hd.MaKH
having count(MaVT) <= all(
select count(ct.MaVT) from HOADON hd, CHITIETHOADON ct
where hd.MaHD = ct.MaHD
group by hd.MaKH))

--8.    Lấy ra vật tư có giá mua thấp nhất
select * from VATTU where GiaMua <= All(
select min(GiaMua) from VATTU)

--9.    Lấy ra vật tư có giá bán cao nhất trong số các vật tư được bán trong năm 2000.
select * from VATTU where MaVT in (
select ct.MaVT from HOADON hd, CHITIETHOADON ct
where hd.MaHD = ct.MaHD and YEAR(hd.Ngay) = 2000
and GiaBan >= All(
select max(GiaBan) from HOADON hd, CHITIETHOADON ct
where hd.MaHD = ct.MaHD and YEAR(hd.Ngay) = 2000))
