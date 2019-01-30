Use SistemaDispensario
GO
CREATE PROCEDURE Select_LastServicio
as
begin
select top 1 *  from Servicios order by Id Desc
end
GO