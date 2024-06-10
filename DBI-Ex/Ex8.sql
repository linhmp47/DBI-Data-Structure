BEGIN TRANSACTION;

-- Chèn thông tin hóa đơn
INSERT INTO HOADON (MaHD, Ngay, MaKH)
VALUES ('HD20', '2019-12-02', 'KH01');

-- Chèn thông tin các sản phẩm vào chi tiết hóa đơn nếu chưa tồn tại
IF NOT EXISTS (SELECT * FROM CHITIETHOADON WHERE MaHD = 'HD20' AND MaVT = 'VT01')
BEGIN
    INSERT INTO CHITIETHOADON (MaHD, MaVT, SL, GiaBan)
    VALUES ('HD20', 'VT01', 10, 55000);
END;

IF NOT EXISTS (SELECT * FROM CHITIETHOADON WHERE MaHD = 'HD20' AND MaVT = 'VT02')
BEGIN
    INSERT INTO CHITIETHOADON (MaHD, MaVT, SL, GiaBan)
    VALUES ('HD20', 'VT02', 2, 47000);
END;

COMMIT;

------------------------------------------------------

BEGIN TRANSACTION;

-- Xóa chi tiết các sản phẩm trong hóa đơn trước
DELETE FROM ChiTietHoaDon WHERE MaHD = 'HD008';

-- Sau đó xóa thông tin hóa đơn
DELETE FROM HoaDon WHERE MaHD = 'HD008';

COMMIT;

