--Hãy thực hiện đánh chỉ mục cho các trường dữ liệu sau:

--1. Trường GiaMua trong bảng VATTU
ALTER TABLE CHITIETHOADON
DROP CONSTRAINT FK_CHITIETHOADON_VATTU

ALTER TABLE VATTU
DROP CONSTRAINT PK__VATTU__60228248C95DEA69;

create clustered index cls_idx_vt on VATTU(GiaMua)

--2. Trường SLTon trong bảng VATTU
create clustered index cls_idx_vt_slton on VATTU(SLTon)

-- Drop the existing clustered index
DROP INDEX cls_idx_vt ON VATTU;

-- Create a new clustered index
CREATE CLUSTERED INDEX cls_idx_vt_slton
ON VATTU (SLTon);

--3. Trường Ngay trong bảng HOADON.
ALTER TABLE CHITIETHOADON
DROP CONSTRAINT FK_CHITIETHOADON_HOADON;

alter table HOADON
drop constraint PK__HOADON__603F20CE84A77DFE

create clustered index cls_idx_hd_ngay on HOADON(Ngay)

--Hãy chọn loại chỉ mục mà bạn cho là phù hợp với các trường này.
-- Chỉ mục phù hợp với các trường này là Clustered Index

