--1. Hiển danh sách tất cả các khách hàng gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
select * from KHACHHANG
--2. Hiển danh sách các khách hàng có địa chỉ là “TAN BINH” gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail. Sắp xếp theo mã khách hàng.
select * from KHACHHANG where DiaChi like '%TAN BINH%'
--3. Hiển danh sách các khách hàng đã có số điện thoại và địa chỉ E-mail gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
select * from KHACHHANG 
where DT is not null and EMAIL is not null
--4. Hiển danh sách tất cả các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá mua.
select * from VATTU
--5. Hiển danh sách các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá mua mà có giá mua nằm trong khoảng từ 20000 đến 40000. Sắp xếp theo giá mua từ lớn xuống bé.
select * from VATTU where GiaMua between 20000 and 40000
order by GiaMua desc
--6. Hiển danh sách các vật tư là “GẠCH” (bao gồm các loại gạch) gồm mã vật tư, tên vật tư, đơn vị tính và giá mua.
select * from VATTU where TenVT like 'GACH%'
--7. Hiển thị số lượng vật tư có trong CSDL
select count(*) from VATTU
--8. Hiển thị cho biết mỗi hóa đơn đã mua bao nhiêu loại vật tư. Thông tin lấy về gồm: Mã hóa đơn, số loại vật tư trong hóa đơn này.
select MaHD, count(MaVT) from CHITIETHOADON group by MaHD
--9. Hiển thị cho biết tổng tiền của mỗi hóa đơn. Thông tin lấy về gồm: mã hóa đơn, tổng tiền của hóa đơn (biết rằng tổng tiền của 1 hóa đơn là tổng tiền của các vật tư trong hóa đơn đó).
select MaHD, sum(SL * GiaBan) from CHITIETHOADON
group by MaHD
--10. Hiển thị cho biết mỗi khách hàng đã mua bao nhiêu hóa đơn. Thông tin lấy về gồm: Mã khách hàng, số lượng hóa đơn khách hàng này đã mua.
select MaKH, count(MaHD) from HOADON
group by MaKH
