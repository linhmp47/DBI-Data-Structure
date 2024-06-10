select * from VATTU

--1. Viết hàm fc_Cau1 có kiểu dữ liệu trả về là int, nhập vào 1 mã vật tư, tìm xem giá mua của vật tư này là bao nhiêu. Kết quả trả về cho hàm là giá mua tìm được.
create function fc_Cau1 (@MaVT nvarchar(10))
returns int as
begin
	declare @GiaMua int
	set @GiaMua = (select top 1 GiaMua from VATTU where MaVT = @MaVT)
	return @GiaMua
end

select dbo.fc_Cau1('VT01')

--2. Viết hàm fc_Cau2 có kiểu dữ liệu trả về là nvarchar(30), nhập vào 1 mã khách hàng, tìm xem khách hàng này có tên là gì. Kết quả trả về cho hàm là tên khách hàng tìm được.
select * from KHACHHANG

create function fc_Cau2 (@MaKH nvarchar(30))
returns nvarchar(30) as
begin
	declare @Ten nvarchar(30)
	set @Ten = (select top 1 TenKH from KHACHHANG where MaKH = @MaKH)
	return @Ten
end

select dbo.fc_Cau2('KH01')

--3. Viết hàm fc_Cau3 có kiểu dữ liệu trả về là int, 
--nhập vào 1 mã khách hàng rồi đếm xem khách hàng này đã mua tổng cộng bao nhiêu tiền. 
--Kết quả trả về cho hàm là tổng số tiền mà khách hàng đã mua.
select MaKH, sum(TongTG) from HOADON where MaKH = 'KH01' group by MaKH

create function fc_Cau3(@MaKH nvarchar(10))
returns int as
begin 
	declare @TongTien int 
	set @TongTien = (select sum(TongTG) from HOADON where MaKH = @MaKH)
	return @TongTien
end

select dbo.fc_Cau3('KH01')

--4. Viết hàm fc_Cau4 có kiểu dữ liệu trả về là nvarchar(5), 
--tìm xem vật tư nào là vật tư bán được nhiều nhất (nhiều tiền nhất). 
--Kết quả trả về cho hàm là mã của vật tư này (trường hợp có nhiều vật tư cùng bán được nhiều nhất, 
--chỉ cần trả về 1 mã bất kỳ trong số đó).
create function fc_Cau4()
returns nvarchar(5) as
begin
declare @MaVT nvarchar(5)
set @MaVT = (select top 1 MaVT from CHITIETHOADON
			where SL*GiaBan >= all(
			select max(SL*GiaBan) from CHITIETHOADON)
			order by SL*GiaBan desc)
return @MaVT
end

select dbo.fc_Cau4()