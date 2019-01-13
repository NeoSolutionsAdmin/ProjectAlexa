USE [SistemaDispensario]
GO

/****** Object:  StoredProcedure [dbo].[GetCharsDiscriminados]    Script Date: 11/01/2019 21:28:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[GetCharsDiscriminados]
as
begin
select * from CharsDiscriminados
end
GO


