use SistemaDispensario
go
CREATE PROCEDURE Insert_Servicio(@NombreServicio varchar(50))
as
begin
insert into Servicios(NombreServicio) values (@NombreServicio)
end
Go
CREATE PROCEDURE Select_AllServicios
as
begin
select * from Servicios
end
go