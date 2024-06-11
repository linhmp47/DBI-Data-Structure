--1. Giá bán của một vật tư bất kỳ cần lớn hơn hoặc bằng giá mua của nó. 
--Ràng buộc này cần được đảm bảo khi insert/update một HOADON 
--hay khi tạo một CHITIETHOADON hoặc update giá bán.
create TRIGGER Exc_9_1 
   ON CHITIETHOADON
   instead of INSERT
AS 
BEGIN
	declare @MaHD nvarchar(10)
		set @MaHD = (select MaHD from inserted)

	declare @MaVT nvarchar(10)
		set @MaVT = (select MaVT from inserted)

	declare @SL int
		set @SL = (select SL from inserted)

	declare @GiaBan int
		set @GiaBan = (select GiaBan from inserted)

	declare @GiaMua int
		set @GiaMua = (select vt.GiaMua from VATTU vt, inserted i where i.MaVT = vt.MaVT)


	if(@GiaBan < @GiaMua)
		print('Khong the insert vao chi tiet hoa don, vi Gia ban < Gia mua');
	else 
		begin
			insert into CHITIETHOADON
			values(@MaHD, @MaVT, @SL, @GiaBan)
		end
END
GO

insert into CHITIETHOADON
values('HD16', 'VT01', 2, 1000000)  


select * from CHITIETHOADON
select * from VATTU
select * from HOADON


--2. Mỗi khi một vật tư được bán ra với một số lượng nào đó, 
--thì thuộc tính SLTon trong bảng VATTU cần giảm đi tương ứng.
create TRIGGER Exc_9_2 
   ON CHITIETHOADON
   after INSERT
AS 
BEGIN
	declare @MaVT nvarchar(10)
	set @MaVT = (select MaVT from inserted)

	declare @SL int
	set @SL = (select SL from inserted)
	update VATTU
	set SLTon = SLTon - @SL
	where MaVT = @MaVT
END
GO

insert into CHITIETHOADON
values('HD15', 'VT02', 20, 1000000)  


select * from CHITIETHOADON
select * from VATTU
select * from HOADON

--3. Đảm bảo giá bán của một sản phẩm bất kỳ, 
--chỉ có thể cập nhật tăng, không thể cập nhật giảm.
alter TRIGGER Exc_9_3
ON CHITIETHOADON
INSTEAD OF UPDATE
AS
BEGIN
    -- Khai báo các biến
    DECLARE @MaSanPham nvarchar(10);
    DECLARE @GiaBanCu DECIMAL(18, 2);
    DECLARE @GiaBanMoi DECIMAL(18, 2);
    
    -- Lấy thông tin từ bảng Inserted và Deleted
    SELECT @MaSanPham = i.MaVT,
           @GiaBanMoi = i.GiaBan,
           @GiaBanCu = d.GiaBan
    FROM Inserted i
    JOIN Deleted d ON i.MaVT = d.MaVT;
    
    -- Kiểm tra nếu giá mới nhỏ hơn giá cũ thì không cho phép cập nhật
    IF @GiaBanMoi < @GiaBanCu
    BEGIN
        RAISERROR ('Giá bán không thể giảm. Cập nhật bị hủy.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        -- Nếu giá mới lớn hơn hoặc bằng giá cũ thì cho phép cập nhật
        UPDATE CHITIETHOADON
        SET GiaBan = @GiaBanMoi
        WHERE MaVT = @MaSanPham;
    END
END;

-- Cập nhật tăng giá cho sản phẩm VT01 (nên thành công)
UPDATE CHITIETHOADON SET GiaBan = 55000.00 WHERE MaVT = 'VT01';

-- Cập nhật giảm giá cho sản phẩm VT01 (nên thất bại)
UPDATE CHITIETHOADON SET GiaBan = 50000.00 WHERE MaVT = 'VT01';

-- Cập nhật tăng giá cho sản phẩm VT02 (nên thành công)
UPDATE CHITIETHOADON SET GiaBan = 1000000.00 WHERE MaVT = 'VT02';

-- Cập nhật giảm giá cho sản phẩm VT02 (nên thất bại)
UPDATE CHITIETHOADON SET GiaBan = 47000.00 WHERE MaVT = 'VT02';



--4. Mỗi khi có sự thay đổi về vật tư được bán trong một hóa đơn nào đó, 
--thuộc tính TONGTG trong bảng HOADON được cập nhật tương ứng.
CREATE TRIGGER Exc_9_4
ON CHITIETHOADON
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Khai báo các biến
    DECLARE @MaHoaDon NVARCHAR(10);

    -- Trường hợp INSERT hoặc UPDATE
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        SELECT @MaHoaDon = MaHD FROM inserted;
    END

    -- Trường hợp DELETE
    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        SELECT @MaHoaDon = MaHD FROM deleted;
    END

    -- Cập nhật lại TONGTG trong bảng HOADON
    UPDATE HOADON
    SET TONGTG = (
        SELECT SUM(SL * GiaBan)
        FROM ChiTietHoaDon
        WHERE MaHD = @MaHoaDon
    )
    WHERE MaHD = @MaHoaDon;
END;

-- Thêm dữ liệu mẫu vào bảng HOADON
INSERT INTO HOADON (MaHoaDon, TONGTG) VALUES ('HD001', 0), ('HD005', 0), ('HD009', 0), ('HD015', 0), ('HD016', 0), ('HD020', 0);

-- Thêm dữ liệu mẫu vào bảng ChiTietHoaDon
INSERT INTO ChiTietHoaDon (MaHoaDon, MaSanPham, SoLuong, GiaBan) VALUES 
('HD001', 'VT01', 5, 52000.00),
('HD005', 'VT05', 10, 33000.00),
('HD005', 'VT06', 15, 35000.00),
('HD005', 'VT07', 20, 17000.00),
('HD009', 'VT02', 25, 48000.00),
('HD015', 'VT02', 20, 1000000.00),
('HD016', 'VT01', 2, 1000000.00),
('HD020', 'VT01', 10, 55000.00),
('HD020', 'VT02', 2, 47000.00);

-- Kiểm tra cập nhật TONGTG trong bảng HOADON
SELECT * FROM HOADON;

-- Thêm chi tiết hóa đơn mới và kiểm tra cập nhật
INSERT INTO CHITIETHOADON VALUES ('HD001', 'VT05', 3, 33000);

select * from CHITIETHOADON

-- Kiểm tra lại TONGTG trong bảng HOADON
SELECT * FROM HOADON;

-- Cập nhật chi tiết hóa đơn và kiểm tra cập nhật
UPDATE CHITIETHOADON SET SL = 6 WHERE MaHD = 'HD001' AND MaVT = 'VT01';

-- Kiểm tra lại TONGTG trong bảng HOADON
SELECT * FROM HOADON;

-- Xóa chi tiết hóa đơn và kiểm tra cập nhật
DELETE FROM CHITIETHOADON WHERE MaHD = 'HD001' AND MaVT = 'VT05';

-- Kiểm tra lại TONGTG trong bảng HOADON
SELECT * FROM HOADON;
