USE [QLBanhang]
GO
/****** Object:  Table [dbo].[CHITIETHOADON]    Script Date: 01-Jun-24 6:52:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHITIETHOADON](
	[MAHD] [nvarchar](10) NOT NULL,
	[MAVT] [nvarchar](5) NOT NULL,
	[SL] [int] NULL,
	[GIABAN] [money] NULL,
 CONSTRAINT [PK__CHITIETH__603F20CE608C0E85] PRIMARY KEY CLUSTERED 
(
	[MAHD] ASC,
	[MAVT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HOADON]    Script Date: 01-Jun-24 6:52:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HOADON](
	[MAHD] [nvarchar](10) NOT NULL,
	[NGAY] [datetime] NULL,
	[MAKH] [nvarchar](5) NULL,
	[TONGTG] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[MAHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KHACHHANG]    Script Date: 01-Jun-24 6:52:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KHACHHANG](
	[MAKH] [nvarchar](5) NOT NULL,
	[TENKH] [nvarchar](50) NULL,
	[DIACHI] [nvarchar](300) NULL,
	[DT] [nvarchar](50) NULL,
	[EMAIL] [nvarchar](50) NULL,
 CONSTRAINT [PK_KHACHHANG] PRIMARY KEY CLUSTERED 
(
	[MAKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VATTU]    Script Date: 01-Jun-24 6:52:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VATTU](
	[MAVT] [nvarchar](5) NOT NULL,
	[TENVT] [nvarchar](30) NULL,
	[DTV] [nvarchar](20) NULL,
	[GIAMUA] [nvarchar](1) NULL,
	[SLTON] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MAVT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[KHACHHANG] ([MAKH], [TENKH], [DIACHI], [DT], [EMAIL]) VALUES (N'KH01 ', N'Nguyễn Hoàng Linhmot          ', N'18 Quốc Lộ 13                                                                                                                                                                                                                                                                                               ', N'0341111111', N'hoanglinhmot@gmail.com        ')
INSERT [dbo].[KHACHHANG] ([MAKH], [TENKH], [DIACHI], [DT], [EMAIL]) VALUES (N'KH02 ', N'Nguyễn Hoàng Linhhai          ', N'19 Quốc Lộ 13                                                                                                                                                                                                                                                                                               ', N'1234567890', N'hoanglinhhai@gmail.com        ')
INSERT [dbo].[KHACHHANG] ([MAKH], [TENKH], [DIACHI], [DT], [EMAIL]) VALUES (N'KH03 ', N'Nguyễn Hoàng Linhba           ', N'20 Quốc Lộ 13                                                                                                                                                                                                                                                                                               ', N'0341111113', N'hoanglinhba@gmail.com         ')
GO
ALTER TABLE [dbo].[CHITIETHOADON]  WITH CHECK ADD  CONSTRAINT [FK_CHITIETHOADON_HOADON] FOREIGN KEY([MAHD])
REFERENCES [dbo].[HOADON] ([MAHD])
GO
ALTER TABLE [dbo].[CHITIETHOADON] CHECK CONSTRAINT [FK_CHITIETHOADON_HOADON]
GO
ALTER TABLE [dbo].[CHITIETHOADON]  WITH CHECK ADD  CONSTRAINT [FK_CHITIETHOADON_VATTU] FOREIGN KEY([MAVT])
REFERENCES [dbo].[VATTU] ([MAVT])
GO
ALTER TABLE [dbo].[CHITIETHOADON] CHECK CONSTRAINT [FK_CHITIETHOADON_VATTU]
GO
ALTER TABLE [dbo].[HOADON]  WITH CHECK ADD  CONSTRAINT [FK_HOADON_KHACHHANG] FOREIGN KEY([MAKH])
REFERENCES [dbo].[KHACHHANG] ([MAKH])
GO
ALTER TABLE [dbo].[HOADON] CHECK CONSTRAINT [FK_HOADON_KHACHHANG]
GO
