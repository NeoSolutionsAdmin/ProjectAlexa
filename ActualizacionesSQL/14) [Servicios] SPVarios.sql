USE SistemaDispensario
go
CREATE PROCEDURE Insert_ProfesionalServicio(@IdUser bigint, @IdServicio bigint)
as
begin
insert into ProfesionalesServicios(IdProfesional,IdServicio) values (@IdUser,@IdServicio)
end
GO
CREATE PROCEDURE Select_LastProfesionalServicio
as
begin
select top 1 * from ProfesionalesServicios order by Id Desc
end
GO
CREATE PROCEDURE Select_IdProfesionalesByIdServicios(@IdServicio bigint)
as
begin
Select IdProfesional from ProfesionalesServicios where IdServicio=@IdServicio
end
GO
CREATE PROCEDURE Select_IdServiciosByIdProfesional(@IdProfesional bigint)
as
begin
select IdServicio from ProfesionalesServicios where IdProfesional=@IdProfesional
end
GO
CREATE PROCEDURE Select_ServicioById(@IdServicio bigint)
as
begin
select * from Servicios where Id=@IdServicio
end
GO
CREATE PROCEDURE Delete_ProfesionalServicioById(@Id bigint)
as
begin
delete ProfesionalesServicios where Id=@Id
end
GO
