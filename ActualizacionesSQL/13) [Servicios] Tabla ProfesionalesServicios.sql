USE [SistemaDispensario]
GO

/****** Object:  Table [dbo].[ProfesionalesServicios]    Script Date: 1/23/2019 12:17:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ProfesionalesServicios](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdProfesional] [bigint] NOT NULL,
	[IdServicio] [bigint] NOT NULL,
 CONSTRAINT [PK_ProfesionalesServicios] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


