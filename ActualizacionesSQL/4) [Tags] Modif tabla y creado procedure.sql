USE [SistemaDispensario]
GO

/****** Object:  Table [dbo].[Tags]    Script Date: 10/01/2019 21:27:19 ******/
DROP TABLE [dbo].[Tags]
GO

/****** Object:  Table [dbo].[Tags]    Script Date: 10/01/2019 21:27:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Tags](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Icono] [varchar](5) NOT NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

USE [SistemaDispensario]
GO

/****** Object:  StoredProcedure [dbo].[GetTagByTagName]    Script Date: 10/01/2019 21:28:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[GetTagByTagName] (@nombreTag varchar(50))
as
begin
select * from Tags where Nombre like '%' + @nombreTag + '%'
end
GO

USE [SistemaDispensario]
GO

/****** Object:  Table [dbo].[CharsDiscriminados]    Script Date: 11/01/2019 2:04:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CharsDiscriminados](
	[Id] [bigint] NOT NULL
) ON [PRIMARY]

GO

USE [SistemaDispensario]
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62117)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62118)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62121)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62122)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62123)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62124)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62125)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62126)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62127)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62128)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62129)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62130)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62131)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62132)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62135)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62136)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62138)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62140)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62142)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62143)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62144)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62147)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62148)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62149)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62150)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62159)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62164)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62165)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62166)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62167)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62168)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62169)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62170)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62173)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62174)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62175)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62176)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62207)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62239)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62235)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62255)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62271)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62287)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62300)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62302)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62303)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62312)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62313)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62314)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62315)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62316)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62317)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62318)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62319)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62320)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62321)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62322)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62323)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62324)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62325)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62328)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62329)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62330)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62331)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62332)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62333)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62335)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62336)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62339)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62340)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62341)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62344)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62347)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62348)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62349)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62350)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62351)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62353)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62354)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62355)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62356)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62357)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62358)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62359)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62360)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62361)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62362)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62365)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62366)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62367)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62369)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62370)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62371)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62372)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62374)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62375)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62376)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62377)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62378)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62379)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62380)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62381)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62382)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62383)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62384)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62385)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62386)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62388)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62389)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62390)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62391)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62392)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62393)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62394)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62395)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62396)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62397)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62400)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62403)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62404)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62406)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62407)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62408)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62410)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62411)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62412)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62416)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62418)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62419)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62420)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62421)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62422)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62423)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62424)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62425)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62426)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62427)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62428)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62431)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62433)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62434)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62435)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62436)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62438)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62439)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62440)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62441)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62442)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62443)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62444)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62446)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62447)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62451)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62453)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62454)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62455)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62456)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62457)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62462)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62466)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62467)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62468)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62469)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62471)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62472)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62473)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62474)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62475)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62476)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62477)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62481)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62482)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62483)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62484)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62485)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62486)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62487)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62488)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62489)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62490)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62491)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62492)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62493)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62494)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62495)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62496)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62497)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62499)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62501)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62502)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62503)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62504)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62505)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62506)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62507)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62508)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62509)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62510)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62511)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62512)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62513)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62546)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62551)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62553)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62677)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62692)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62693)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62694)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62695)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62696)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62697)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62698)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62699)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62700)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62701)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62702)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62703)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62704)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62705)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62706)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62707)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62708)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62709)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62710)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62711)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62712)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62713)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62730)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62731)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62732)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62733)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62734)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62735)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62736)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62737)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62738)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62739)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62740)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62883)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62888)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62898)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62866)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62901)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62910)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62878)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62927)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62924)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62918)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62961)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62967)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62970)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62994)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62991)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62994)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63039)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63042)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63151)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63133)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63177)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63178)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63180)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63196)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63236)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63281)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63280)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63325)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63352)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63354)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63355)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63365)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63369)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63373)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63385)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63384)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63383)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63377)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63376)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63407)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63408)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63409)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63411)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63419)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63420)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63430)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63457)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63456)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63455)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63446)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (63443)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62117)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62118)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62121)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62122)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62123)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62124)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62125)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62126)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62127)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62128)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62129)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62130)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62131)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62132)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62135)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62136)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62138)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62140)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62142)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62143)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62176)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62175)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62174)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62173)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62170)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62169)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62168)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62167)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62166)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62165)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62164)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62159)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62150)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62149)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62148)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62147)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62144)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62207)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62239)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62235)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62255)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62271)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62303)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62302)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62300)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62287)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62312)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62313)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62314)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62315)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62316)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62317)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62318)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62319)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62320)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62321)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62322)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62323)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62324)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62325)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62328)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62329)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62330)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62331)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62332)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62333)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62335)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62336)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62367)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62366)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62365)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62362)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62361)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62360)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62359)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62358)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62357)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62356)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62355)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62354)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62353)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62351)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62350)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62349)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62348)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62347)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62344)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62341)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62340)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62339)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62369)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62370)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62371)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62372)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62374)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62375)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62376)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62377)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62378)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62379)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62380)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62381)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62382)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62383)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62384)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62385)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62386)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62388)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62389)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62390)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62391)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62392)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62393)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62394)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62395)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62396)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62397)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62431)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62428)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62427)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62426)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62425)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62424)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62423)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62422)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62390)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62389)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62390)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62422)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62421)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62420)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62419)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62418)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62416)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62412)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62411)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62410)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62408)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62407)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62406)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62404)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62403)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62400)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62433)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62434)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62435)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62436)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62438)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62439)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62440)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62441)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62442)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62443)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62444)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62446)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62447)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62451)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62453)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62454)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62455)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62456)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62457)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62462)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62494)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62493)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62492)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62491)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62490)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62489)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62488)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62487)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62486)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62485)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62484)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62483)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62482)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62481)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62477)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62476)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62475)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62474)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62473)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62472)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62471)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62469)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62468)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62467)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62466)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62495)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62496)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62497)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62499)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62501)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62502)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62503)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62504)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62505)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62506)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62507)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62508)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62509)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62510)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62511)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62512)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62513)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62553)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62551)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62546)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62541)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62692)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62693)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62694)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62695)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62696)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62697)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62698)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62699)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62700)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62701)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62702)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62703)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62704)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62705)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62706)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62707)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62708)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62709)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62710)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62711)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62740)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62739)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62738)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62737)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62736)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62735)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62734)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62733)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62732)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62731)
GO
INSERT [dbo].[CharsDiscriminados] ([Id]) VALUES (62730)
GO