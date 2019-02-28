ALTER PROCEDURE Select_JornadaLaboralByIdServicioAndDateComienzo(@DAY bigint, @MONTH bigint, @YEAR bigint, @IdServicio bigint)
as
begin
declare @fechainicio varchar(50)
declare @fechafinal varchar(50)
set @fechainicio = CAST(@YEAR as varchar(10)) + '-' + CAST(@MONTH as varchar(10))  + '-' + CAST(@DAY as varchar(10)) + ' 00:00:00.00'
set @fechafinal = CAST(@YEAR as varchar(10)) + '-' + CAST(@MONTH as varchar(10))  + '-' + CAST(@DAY as varchar(10)) + ' 23:59:59.00'
select * from CronogramaLaboral where SalidaJornada IS NOT NULL AND EntradaJornada between CONVERT(datetime,@fechainicio,120) and convert(datetime,@fechafinal,120) and IdServicio=@IdServicio
end

