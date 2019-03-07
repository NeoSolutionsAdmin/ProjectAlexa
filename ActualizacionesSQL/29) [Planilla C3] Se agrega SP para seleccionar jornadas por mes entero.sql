USE [SistemaDispensario]
GO

/****** Object:  StoredProcedure [dbo].[Select_JornadaLaboralByIdServicioAndDateComienzo]    Script Date: 3/1/2019 2:33:17 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Select_JornadaLaboralByIdServicioAndEntireMonth](@LASTDAY bigint, @MONTH bigint, @YEAR bigint, @IdServicio bigint)
as
begin
declare @fechainicio varchar(50)
declare @fechafinal varchar(50)
set @fechainicio = CAST(@YEAR as varchar(10)) + '-' + CAST(@MONTH as varchar(10))  + '-1' + ' 00:00:00.00'
set @fechafinal = CAST(@YEAR as varchar(10)) + '-' + CAST(@MONTH as varchar(10))  + '-' + CAST(@LASTDAY as varchar(10)) + ' 23:59:59.00'
select * from CronogramaLaboral where SalidaJornada IS NOT NULL AND EntradaJornada between CONVERT(datetime,@fechainicio,120) and convert(datetime,@fechafinal,120) and IdServicio=@IdServicio
end


GO


