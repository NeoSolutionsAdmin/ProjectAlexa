USE [SistemaDispensario]
GO

/****** Object:  Table [dbo].[RegistroC1]    Script Date: 10/27/2018 6:41:59 PM ******/
DROP TABLE [dbo].[RegistroC1]
GO

/****** Object:  Table [dbo].[RegistroC1]    Script Date: 10/27/2018 6:41:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RegistroC1](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[fechaC1] [datetime] NOT NULL,
	[UserId] bigint NOT NULL,
	[CantidadHoras] [bigint] NOT NULL,
	
 CONSTRAINT [PK_RegistroC1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE PROCEDURE InsertRegistroC1(@UserId bigint, @CantidadHoras bigint, @fechac1 varchar(50))
as
begin
insert into RegistroC1(UserId,CantidadHoras,fechaC1) values (@UserId,@CantidadHoras,@fechac1)
end

GO

CREATE PROCEDURE SelectC1FromUserId(@UserId bigint)
as
begin
	select * from RegistroC1 where UserId=@UserId
end

GO
