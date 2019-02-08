USE [SistemaDispensario]
GO

/****** Object:  Table [dbo].[CronogramaLaboral]    Script Date: 2/2/2019 8:40:18 PM ******/
DROP TABLE [dbo].[CronogramaLaboral]
GO

/****** Object:  Table [dbo].[CronogramaLaboral]    Script Date: 2/2/2019 8:40:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CronogramaLaboral](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[EntradaJornada] [datetime] NOT NULL,
	[SalidaJornada] [datetime] NULL,
	[Horas] [decimal](4, 2) NULL,
	IdServicio bigint not null

 CONSTRAINT [PK_CronogramaLaboral] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
CREATE PROCEDURE GET_LastCronogramaByIdServiceAndIdUser(@userId bigint, @serviceId bigint)
as
begin
select Top 1 *  from CronogramaLaboral where userId=@userId and IdServicio=@serviceId Order By Id Desc
end

