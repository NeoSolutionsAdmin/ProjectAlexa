USE SistemaDispensario
go
CREATE PROCEDURE Select_ProfesionalServicioByBothId(@IdUser bigint, @IdServicio bigint)
as
begin
select * from ProfesionalesServicios where IdProfesional=@IdUser and IdServicio=@IdServicio
end
GO
