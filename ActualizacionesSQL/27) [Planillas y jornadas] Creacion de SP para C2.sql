CREATE PROCEDURE Select_JornadaLaboralByIdServicioAndDateComienzo(@DAY bigint, @MONTH bigint, @YEAR bigint, @IdServicio bigint)
as
begin
declare @fechacompleta varchar(50)
set @fechacompleta = CAST(@YEAR as varchar(10)) + '-' + CAST(@MONTH as varchar(10))  + '-' + CAST(@DAY as varchar(10)) 
select * from CronogramaLaboral where SalidaJornada IS NOT NULL AND EntradaJornada=CONVERT(datetime,@fechaCompleta,120) and IdServicio=@IdServicio
end

