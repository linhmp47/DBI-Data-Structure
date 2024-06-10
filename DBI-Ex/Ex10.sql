--1. Viết procedure sp_Cau1 cập nhật thông tin TONGGT trong bảng hóa đơn theo dữ liệu thực tế của bảng CHITIETHOADON
create procedure sp_Cau1 (@MaHD nvarchar(10))
as
	begin
	declare @TongTien int
	set @TongTien = (select sum(SL*GiaBan) from CHITIETHOADON where MaHD = @MaHD)
	update HOADON
	set TongTG = @TongTien
	where MaHD = @MaHD
	end

	exec sp_Cau1 'HD001'

select * from HOADON
select * from CHITIETHOADON
--2. Viết procedure sp_Cau2 có đầu vào là số điện thoại, kiểm tra xem đã có khách hàng có số điện thoại này trong CSDL chưa? 
--Hiện thông báo (bằng lệnh print) để nêu rõ đã có/ chưa có khách hàng này.
create proc sp_Cau2 @SDT nvarchar(10)
as begin
	if(exists(select * from KHACHHANG where DT = @SDT))
		print('Khach hang da co')
	else
		print('Khach hang chua co')
end

exec sp_Cau2 '8457895'
exec sp_Cau2 '8457891'

select * from KHACHHANG
--3. Viết procedure sp_Cau3 có đầu vào là mã khách hàng, hãy tính tổng số tiền mà khách hàng này đã mua trong toàn  ệ thống, 
--kết quả trả về trong một tham số kiểu output.
create proc sp_Cau3(@MaKH nvarchar(10), @TongTien int output)
as
	begin
	set @TongTien =(select sum(TongTG) from HOADON where MaKH = @MaKH)
	end

declare @TongTien1 int

exec sp_Cau3 'KH01', @TongTien1
print(@TongTien1)

alter proc sp_Cau3 (@MaKH nvarchar(10), @TongTien int output)
as
	begin
	set @TongTien =(select sum(TongTG) from HOADON where MaKH = @MaKH)
	end

declare @TongTien1 int
exec sp_Cau3 'KH04',@TongTien1 output
print(@TongTien1)

select * from HOADON

--4. Viết procedure sp_Cau4 có hai tham số kiểu output là @mavt nvarchar(5) và @tenvt nvarchar(30) để trả về mã và tên của vật tư 
--đã bán được nhiều nhất (được tổng tiền nhiều nhất).
create proc sp_Cau4(@MaVT nvarchar(10) output, @TenVT nvarchar(30) output)
as
	begin
		set @MaVT = (select MaVT from VATTU where MaVT in (
select MaVT from CHITIETHOADON
where SL*GiaBan >= all(select max(SL*GiaBan) from CHITIETHOADON)))

set @TenVT = (select TenVT from VATTU where MaVT in (
select MaVT from CHITIETHOADON
where SL*GiaBan >= all(select max(SL*GiaBan) from CHITIETHOADON)))

end

declare @MaVT nvarchar(10)
declare @TenVT nvarchar(30)

exec sp_Cau4 @MaVT output, @TenVT output
select @MaVT, @TenVT